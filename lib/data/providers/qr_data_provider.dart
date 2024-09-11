import '../models/qr_data_model.dart';
import '../services/clients/_clients.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart' as sql;

part 'qr_data_provider.g.dart';

@riverpod
class AddQRData extends _$AddQRData with AsyncXNotifierMixin<QrDataModel> {
  @override
  Future<AsyncX<QrDataModel>> build() => idle();
  @useResult
  RunXCallback<void> addQRdata(QrDataModel qrCode) => handle(() async {
        final db = await _getDatabase();
        db.insert(
          'scanned_qr_codes',
          qrCode.toJson(),
        );
        return qrCode;
      });
}

@riverpod
Stream<List<QrDataModel>> getQRDataHistory(GetQRDataHistoryRef ref) async* {
  final db = await _getDatabase();
  yield* Stream.periodic(const Duration(seconds: 0), (_) async {
    List<dynamic> data = await db.query('scanned_qr_codes');
    return data.map((qrData) => QrDataModel.fromJson(qrData)).toList();
  }).asyncMap((event) => event);
}

@riverpod
class DeleteQRDataProvider extends _$DeleteQRDataProvider with AsyncXNotifierMixin<void> {
  @override
  Future<AsyncX<void>> build() => idle();
  @useResult
  RunXCallback<void> deleteTable() => handle(() async {
        final db = await _getDatabase();
        await db.execute('DROP TABLE IF EXISTS scanned_qr_codes');
        return;
      });
}

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
      path.join(dbPath, 'lib', 'data', 'services', 'databaseses', 'scanned_qr_codes.db'),
      onCreate: (db, version) {
    return db.database.execute(
        'CREATE TABLE scanned_qr_codes(id TEXT PRIMARY KEY, data TEXT, date TEXT, type TEXT)');
  }, version: 1);
  return db;
}

@riverpod
class DeleteQRData extends _$DeleteQRData with AsyncXNotifierMixin<dynamic> {
  @override
  Future<AsyncX<dynamic>> build() => idle();

  @useResult
  RunXCallback<dynamic> deleteQRdata(String id) => handle(() async {
        final db = await _getDatabase();
        await db.delete(
          'scanned_qr_codes',
          where: 'id = ?',
          whereArgs: [id],
        );
        return;
      });
}