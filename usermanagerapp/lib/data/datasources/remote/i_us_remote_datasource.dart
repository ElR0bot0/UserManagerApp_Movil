import '../../../domain/entities/us.dart';

abstract class IUSRemoteDataSource {
  Future<void> addUS(US us);
  Future<List<US>> getAllUSs();
  Future<void> deleteUS(String id);
  Future<void> updateUS(US us);
  Future<bool> authenticateUS(String email, String password);
  Future<US?> getUSById(String id);
  Future<US?> getUSByEmail(String email);
}
