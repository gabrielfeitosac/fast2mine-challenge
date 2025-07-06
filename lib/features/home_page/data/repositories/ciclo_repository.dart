import 'package:fast2mine_challenge/features/home_page/data/datasources/ciclo_local_datasource.dart';
import 'package:fast2mine_challenge/features/home_page/data/models/ciclo.dart';
import 'package:fast2mine_challenge/features/home_page/domain/repositories/iciclo_repository.dart';
import 'package:get_it/get_it.dart';

class CicloRepository implements ICicloRepository {
  final ICicloLocalDataSource localDataSource =
      GetIt.instance.get<ICicloLocalDataSource>();

  @override
  Future<bool> create(Ciclo ciclo) async {
    await localDataSource.create(ciclo.toJson());
    return true;
  }

  @override
  Future<List<Ciclo>> getUnsynchronized() async {
    final result = await localDataSource.getUnsynchronized();
    return result.map((json) => Ciclo.fromJson(json)).toList();
  }

  @override
  Future<int> update(Ciclo ciclo) async {
    return await localDataSource.update(ciclo.toJson(), ciclo.cicloId);
  }

  @override
  Future<Ciclo?> getById(String id) async {
    final rawResponse = await localDataSource.getById(id);
    if (rawResponse == null) return null;
    return Ciclo.fromJson(rawResponse);
  }
}
