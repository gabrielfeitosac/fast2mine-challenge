import 'package:fast2mine_challenge/features/home_page/data/models/ciclo.dart';

abstract class ICicloRepository {
  Future<bool> create(Ciclo ciclo);
  Future<int> update(Ciclo ciclo);
  Future<List<Ciclo>> getUnsynchronized();
  Future<Ciclo?> getById(String id);
}
