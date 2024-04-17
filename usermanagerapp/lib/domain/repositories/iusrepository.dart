import '../entities/US.dart';

abstract class IUSRepository {
  Future<bool> getUS();
  Future<List<US>> getAllUSs();
  Future<void> deleteUS(id);
  Future<void> updateUS(us);
  Future<void> addUS(id);
  Future<String> getAvgRating(uss);
}
