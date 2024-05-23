import '../../domain/entities/us.dart';

abstract class IUSRepository {
  Future<bool> addUS(US usi);
  Future<List<US>> getAllUSs();
  Future<void> deleteUS(String id);
  Future<void> updateUS(US uss);
  Future<bool> authenticateUS(String email, String password);
  Future<US?> getUSById(String id);
  Future<US?> getUSByEmail(String email);
}
