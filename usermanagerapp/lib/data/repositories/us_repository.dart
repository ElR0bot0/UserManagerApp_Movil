import 'package:loggy/loggy.dart';
import '../../domain/entities/us.dart';
import '../datasources/remote/us_remote_datasource.dart';

class USRepository {
  late USRemoteDataSource _uSDatatasource;

  USRepository() {
    logInfo("Starting USRepository");
    _uSDatatasource = USRemoteDataSource();
  }

  Future<bool> addUS(US usi) async {
    try {
      return await _uSDatatasource.addUS(usi);
    } catch (error) {
      logError('Error adding US in repository: $error');
      return false;
    }
  }

  Future<List<US>> getAllUSs() async {
    try {
      var list = await _uSDatatasource.getAllUSs();
      return list;
    } catch (error) {
      logError('Error getting all USs in repository: $error');
      return [];
    }
  }

  Future<bool> deleteUS(String id) async {
    try {
      return await _uSDatatasource.deleteUS(id);
    } catch (error) {
      logError('Error deleting US in repository: $error');
      return false;
    }
  }

  Future<bool> updateUS(US uss) async {
    try {
      return await _uSDatatasource.updateUS(uss);
    } catch (error) {
      logError('Error updating US in repository: $error');
      return false;
    }
  }

  Future<bool> authenticateUS(String email, String password) async =>
      await _uSDatatasource.authenticateUS(email, password);

  Future<US?> getUSById(String id) async {
    try {
      return await _uSDatatasource.getUSById(id);
    } catch (error) {
      logError('Error getting US by ID in repository: $error');
      return null;
    }
  }

  Future<US?> getUSByEmail(String email) async {
    try {
      return await _uSDatatasource.getUSByEmail(email);
    } catch (error) {
      logError('Error getting US by Email in repository: $error');
      return null;
    }
  }
}
