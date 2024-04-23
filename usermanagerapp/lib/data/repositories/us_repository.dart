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
      await _uSDatatasource.addUS(usi);
      return true;
    } catch (error) {
      logError('Error adding US in repository: $error');
      return false;
    }
  }

  Future<List<US>> getAllUSs() async {
    try {
      return await _uSDatatasource.getAllUSs();
    } catch (error) {
      logError('Error getting all USs in repository: $error');
      return [];
    }
  }

  Future<void> deleteUS(String id) async {
    try {
      await _uSDatatasource.deleteUS(id);
    } catch (error) {
      logError('Error deleting US in repository: $error');
    }
  }

  Future<void> updateUS(US uss) async {
    try {
      await _uSDatatasource.updateUS(uss);
    } catch (error) {
      logError('Error updating US in repository: $error');
    }
  }

  Future<bool> authenticateUS(String email, String password) async => await _uSDatatasource.authenticateUS(email, password);
}
