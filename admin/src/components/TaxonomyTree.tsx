'use client';

import { useState, useEffect } from 'react';
import { api, TaxonomyNode } from '@/lib/api';

export default function TaxonomyTree() {
  const [nodes, setNodes] = useState<TaxonomyNode[]>([]);
  const [loading, setLoading] = useState(true);
  const [newName, setNewName] = useState('');
  const [newParent, setNewParent] = useState('');
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editName, setEditName] = useState('');

  useEffect(() => {
    api.taxonomy.list().then(setNodes).catch(console.error).finally(() => setLoading(false));
  }, []);

  function flattenNodes(tree: TaxonomyNode[], depth = 0): { id: string; name: string; parentId: string | null; depth: number }[] {
    const result: { id: string; name: string; parentId: string | null; depth: number }[] = [];
    for (const n of tree) {
      result.push({ id: n.id, name: n.name, parentId: n.parentId, depth });
      if (n.children) result.push(...flattenNodes(n.children, depth + 1));
    }
    return result;
  }

  async function handleAdd() {
    if (!newName.trim()) return;
    try {
      const node = await api.taxonomy.create({ name: newName, parentId: newParent || null });
      setNewName('');
      const updated = await api.taxonomy.list();
      setNodes(updated);
    } catch (err) {
      console.error(err);
    }
  }

  async function handleEdit(id: string) {
    if (!editName.trim()) return;
    try {
      await api.taxonomy.update(id, { name: editName });
      setEditingId(null);
      setEditName('');
      const updated = await api.taxonomy.list();
      setNodes(updated);
    } catch (err) {
      console.error(err);
    }
  }

  if (loading) return <p className="text-gray-500">Loading taxonomy...</p>;

  const flat = flattenNodes(nodes);

  return (
    <div className="space-y-6">
      <div className="bg-white rounded shadow p-4">
        <h3 className="font-medium mb-3">Add Node</h3>
        <div className="flex gap-3">
          <input
            type="text"
            placeholder="Node name"
            className="border rounded px-3 py-2 text-sm flex-1"
            value={newName}
            onChange={(e) => setNewName(e.target.value)}
          />
          <select
            className="border rounded px-3 py-2 text-sm"
            value={newParent}
            onChange={(e) => setNewParent(e.target.value)}
          >
            <option value="">Root (no parent)</option>
            {flat.map((n) => (
              <option key={n.id} value={n.id}>{'  '.repeat(n.depth)}{n.name}</option>
            ))}
          </select>
          <button
            onClick={handleAdd}
            className="bg-indigo-600 text-white px-4 py-2 rounded text-sm"
          >
            Add
          </button>
        </div>
      </div>

      <div className="bg-white rounded shadow p-4">
        <h3 className="font-medium mb-3">Taxonomy Tree</h3>
        {nodes.length === 0 ? (
          <p className="text-gray-500">No taxonomy nodes yet.</p>
        ) : (
          <ul className="space-y-1">
            {renderTree(nodes, 0, editingId, editName, setEditingId, setEditName, handleEdit)}
          </ul>
        )}
      </div>
    </div>
  );
}

function renderTree(
  nodes: TaxonomyNode[],
  depth: number,
  editingId: string | null,
  editName: string,
  setEditingId: (id: string | null) => void,
  setEditName: (name: string) => void,
  handleEdit: (id: string) => void
): React.ReactNode {
  return nodes.map((node) => (
    <li key={node.id}>
      <div
        className="flex items-center gap-2 py-1 hover:bg-gray-50 rounded px-2"
        style={{ paddingLeft: `${depth * 20 + 8}px` }}
      >
        {editingId === node.id ? (
          <>
            <input
              type="text"
              className="border rounded px-2 py-1 text-sm flex-1"
              value={editName}
              onChange={(e) => setEditName(e.target.value)}
              autoFocus
            />
            <button
              onClick={() => handleEdit(node.id)}
              className="text-green-600 text-xs font-medium"
            >
              Save
            </button>
            <button
              onClick={() => setEditingId(null)}
              className="text-gray-500 text-xs"
            >
              Cancel
            </button>
          </>
        ) : (
          <>
            <span className="text-sm">{node.name}</span>
            <button
              onClick={() => { setEditingId(node.id); setEditName(node.name); }}
              className="text-indigo-600 text-xs ml-2"
            >
              Edit
            </button>
          </>
        )}
      </div>
      {node.children && node.children.length > 0 && (
        <ul>
          {renderTree(node.children, depth + 1, editingId, editName, setEditingId, setEditName, handleEdit)}
        </ul>
      )}
    </li>
  ));
}
