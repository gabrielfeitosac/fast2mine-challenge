import 'package:fast2mine_challenge/core/config/database_helper.dart';
import 'package:get_it/get_it.dart';

abstract class ICicloLocalDataSource {
  Future<void> create(Map<String, dynamic> item);
  Future<int> update(Map<String, dynamic> item, String id);
  Future<List<Map<String, dynamic>>> getUnsynchronized();
  Future<Map<String, dynamic>?> getById(String id);
}

class CicloLocalDatasource implements ICicloLocalDataSource {
  final dbHelper = GetIt.instance.get<DatabaseHelper>();

  @override
  Future<void> create(Map<String, dynamic> item) async {
    await dbHelper.insert('Ciclos', item);
  }

  @override
  Future<List<Map<String, dynamic>>> getUnsynchronized() async {
    final result = await dbHelper.getAllWhere(
        'Ciclos', ''' status_sincronizacao = 'NÃO SINCRONIZADO' ''');
    return result;
  }

  @override
  Future<int> update(Map<String, dynamic> item, String id) async {
    return dbHelper.update(
      'Ciclos',
      item,
      where: 'ciclo_id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<Map<String, dynamic>?> getById(String id) async {
    final result = await dbHelper
        .rawQuery(''' SELECT * FROM Ciclos WHERE ciclo_id = '$id' ''');
    return result.firstOrNull;
  }
}
