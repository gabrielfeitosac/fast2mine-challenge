import 'package:fast2mine_challenge/core/config/database_helper.dart';
import 'package:fast2mine_challenge/features/home_page/data/datasources/ciclo_local_datasource.dart';
import 'package:fast2mine_challenge/features/home_page/data/repositories/ciclo_repository.dart';
import 'package:fast2mine_challenge/features/home_page/domain/repositories/iciclo_repository.dart';
import 'package:get_it/get_it.dart';

void initInstances() {
  final databaseHelper = DatabaseHelper.databaseInstance;
  databaseHelper.database;
  GetIt.instance.registerSingleton<DatabaseHelper>(databaseHelper);
  GetIt.instance
      .registerLazySingleton<ICicloRepository>(() => CicloRepository());
  GetIt.instance.registerLazySingleton<ICicloLocalDataSource>(
      () => CicloLocalDatasource());
}
