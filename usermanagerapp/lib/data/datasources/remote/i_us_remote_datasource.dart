import '../../../domain/entities/us.dart';

abstract class IUSRemoteDataSource {
  Future<bool> addUS(US us);
  Future<List<US>> getAllUSs();
  Future<bool> deleteUS(String id);
  Future<bool> updateUS(US us);
  Future<bool> authenticateUS(String email, String password);
  Future<US?> getUSById(String id);
  Future<US?> getUSByEmail(String email);
}
