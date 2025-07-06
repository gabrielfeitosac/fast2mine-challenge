import 'package:fast2mine_challenge/features/home_page/data/models/ciclo.dart';
import 'package:fast2mine_challenge/features/home_page/domain/repositories/iciclo_repository.dart';
import 'package:get_it/get_it.dart';

abstract class ICreateOrUpdateCicloUsecase {
  Future<bool> call(Ciclo ciclo);
}

class CreateOrUpdateCicloUsecase implements ICreateOrUpdateCicloUsecase {
  final ICicloRepository _repository = GetIt.instance.get<ICicloRepository>();

  @override
  Future<bool> call(Ciclo ciclo) async {
    final databaseCiclo = await _repository.getById(ciclo.cicloId);

    if (databaseCiclo != null) {
      final response = await _repository.update(ciclo);
      return response > 0;
    }

    final response = await _repository.create(ciclo);
    return response;
  }
}
