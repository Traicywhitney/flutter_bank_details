import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class databaseHelper {
  static const _databaseName = "BankDetailsDB.db";
  static const _databaseVersion = 3;

  static const bankDetailsTable = 'bank_details_table';
  static const columnId = '_id';

  static const columnBankName = '_bankName';
  static const columnBranchName = '_branchName';
  static const columnAccountType = '_accountType';
  static const columnAccountNo = '_accountNo';
  static const columnIFSCCode = '_IFSCCode';

  late Database _db;

  Future<void> initialization() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute('''
          CREATE TABLE $bankDetailsTable (
            $columnId INTEGER PRIMARY KEY,
            $columnBankName TEXT,
            $columnBranchName TEXT,
            $columnAccountType TEXT,
            $columnAccountNo TEXT,
            $columnIFSCCode TEXT
          )
          ''');
  }

  _onUpgrade(Database database, int oldVersion, int newVersion) async{
    await database.execute('drop table $bankDetailsTable');
    _onCreate(database, newVersion);
  }

  Future<int> insertBankDetails(Map<String, dynamic> row, String tableName) async {
    return await _db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    return await _db.query(tableName);
  }
  Future<int> updateBankDetails(Map<String, dynamic> row, String tableName) async {
    int id = row[columnId];
    return await _db.update(
      tableName,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
  Future<int> deleteBankDetails(int id, String tableName) async {
    return await _db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
