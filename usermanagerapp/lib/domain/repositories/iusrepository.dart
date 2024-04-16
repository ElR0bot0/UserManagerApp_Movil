import '../entities/US.dart';

abstract class IUSRepository {
  Future<bool> getUS();
  Future<List<US>> getAllUSs();
  Future<void> deleteUS(id);
  Future<void> updateUS(user);
  Future<void> addUS(id);
}
