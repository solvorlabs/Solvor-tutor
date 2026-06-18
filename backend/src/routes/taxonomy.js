const { Router } = require('express');
const { v4: uuidv4 } = require('uuid');
const { query } = require('../db/connection');
const { authenticate } = require('../middleware/auth');

const router = Router();

// GET /taxonomy — full taxonomy tree
router.get('/', authenticate, async (req, res, next) => {
  try {
    const result = await query(
      'SELECT id, name, parent_id, level FROM taxonomy_nodes ORDER BY level, name'
    );

    const nodes = result.rows;
    const map = new Map();
    const roots = [];

    for (const node of nodes) {
      map.set(node.id, { ...node, children: [] });
    }

    for (const node of nodes) {
      const mapped = map.get(node.id);
      if (node.parent_id && map.has(node.parent_id)) {
        map.get(node.parent_id).children.push(mapped);
      } else {
        roots.push(mapped);
      }
    }

    res.json(roots);
  } catch (err) {
    next(err);
  }
});

// POST /taxonomy — create new node
router.post('/', authenticate, async (req, res, next) => {
  try {
    const { name, parentId } = req.body;

    if (!name || !name.trim()) {
      return res.status(400).json({ error: 'name is required' });
    }

    let level = 0;
    if (parentId) {
      const parent = await query('SELECT level FROM taxonomy_nodes WHERE id = $1', [parentId]);
      if (parent.rows.length === 0) {
        return res.status(404).json({ error: 'Parent node not found' });
      }
      level = parent.rows[0].level + 1;
    }

    const id = uuidv4();
    await query(
      'INSERT INTO taxonomy_nodes (id, name, parent_id, level) VALUES ($1, $2, $3, $4)',
      [id, name.trim(), parentId || null, level]
    );

    res.status(201).json({ id, name: name.trim(), parentId: parentId || null, level });
  } catch (err) {
    next(err);
  }
});

// PUT /taxonomy/:id — rename node
router.put('/:id', authenticate, async (req, res, next) => {
  try {
    const { id } = req.params;
    const { name } = req.body;

    if (!name || !name.trim()) {
      return res.status(400).json({ error: 'name is required' });
    }

    const existing = await query('SELECT id FROM taxonomy_nodes WHERE id = $1', [id]);
    if (existing.rows.length === 0) {
      return res.status(404).json({ error: 'Node not found' });
    }

    await query('UPDATE taxonomy_nodes SET name = $1 WHERE id = $2', [name.trim(), id]);
    res.json({ id, name: name.trim() });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
