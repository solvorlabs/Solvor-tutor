import 'package:drift/drift.dart';

import '../app_database.dart';

part 'sync_ledger_dao.g.dart';

@DriftAccessor(tables: [SyncLedger])
class SyncLedgerDao extends DatabaseAccessor<AppDatabase>
    with _$SyncLedgerDaoMixin {
  SyncLedgerDao(super.db);

  Future<void> enqueueEvent(SyncLedgerCompanion event) async {
    await into(syncLedger).insert(event);
  }

  Future<List<SyncLedgerData>> getUnprocessedEvents() async {
    return (select(syncLedger)
          ..where((t) => t.processedStatus.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.clientTimestamp)]))
        .get();
  }

  Future<void> markProcessed(String id) async {
    await (update(syncLedger)..where((t) => t.id.equals(id))).write(
      const SyncLedgerCompanion(processedStatus: Value(true)),
    );
  }

  Future<void> markAllProcessed() async {
    await (update(syncLedger)..where((t) => t.processedStatus.equals(false)))
        .write(const SyncLedgerCompanion(processedStatus: Value(true)));
  }

  Future<int> getPendingCount() async {
    final events = await getUnprocessedEvents();
    return events.length;
  }
}
