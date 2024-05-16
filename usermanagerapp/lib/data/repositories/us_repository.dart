import 'package:loggy/loggy.dart';
import '../../domain/entities/us.dart';
import '../../domain/repositories/iusrepository.dart';
import '../datasources/remote/us_remote_datasource.dart';

class USRepository implements IUSRepository {
  late USRemoteDataSource _uSDatatasource;

  USRepository() {
    logInfo("Starting USRepository");
    _uSDatatasource = USRemoteDataSource();
  }

  @override
  Future<bool> addUS(US usi) async {
    try {
      await _uSDatatasource.addUS(usi);
      return true;
    } catch (error) {
      logError('Error adding US in repository: $error');
      return false;
    }
  }

  @override
  Future<List<US>> getAllUSs() async {
    try {
      var list = await _uSDatatasource.getAllUSs();
      return list;
    } catch (error) {
      logError('Error getting all USs in repository: $error');
      return [];
    }
  }

  @override
  Future<void> deleteUS(String id) async {
    try {
      await _uSDatatasource.deleteUS(id);
    } catch (error) {
      logError('Error deleting US in repository: $error');
    }
  }

  @override
  Future<void> updateUS(US uss) async {
    try {
      await _uSDatatasource.updateUS(uss);
    } catch (error) {
      logError('Error updating US in repository: $error');
    }
  }

  @override
  Future<bool> authenticateUS(String email, String password) async {
    return await _uSDatatasource.authenticateUS(email, password);
  }

  @override
  Future<US?> getUSById(String id) async {
    try {
      return await _uSDatatasource.getUSById(id);
    } catch (error) {
      logError('Error getting US by ID in repository: $error');
      return null;
    }
  }

  @override
  Future<US?> getUSByEmail(String email) async {
    try {
      return await _uSDatatasource.getUSByEmail(email);
    } catch (error) {
      logError('Error getting US by Email in repository: $error');
      return null;
    }
  }
}
