import 'package:fast2mine_challenge/features/home_page/data/models/ciclo.dart';
import 'package:fast2mine_challenge/features/home_page/domain/repositories/iciclo_repository.dart';
import 'package:get_it/get_it.dart';

abstract class IGetUnsynchronizedCiclosUsecase {
  Future<List<Ciclo>> call();
}

class GetUnsynchronizedCiclosUsecase
    implements IGetUnsynchronizedCiclosUsecase {
  final ICicloRepository _repository = GetIt.instance.get<ICicloRepository>();

  @override
  Future<List<Ciclo>> call() async {
    final response = await _repository.getUnsynchronized();
    return response;
  }
}
