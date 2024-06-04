import 'package:f_testing_template/data/datasources/remote/i_us_remote_datasource.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/us.dart';
import '../../domain/repositories/iusrepository.dart';

class USRepository implements IUSRepository {
  final IUSRemoteDataSource _uSDatatasource;

  USRepository(this._uSDatatasource);

  @override
  Future<bool> addUS(US usi) async {
    try {
      return await _uSDatatasource.addUS(usi);
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
  Future<bool> deleteUS(String id) async {
    try {
      return await _uSDatatasource.deleteUS(id);
    } catch (error) {
      logError('Error deleting US in repository: $error');
      return false;
    }
  }

  @override
  Future<bool> updateUS(US uss) async {
    try {
      return await _uSDatatasource.updateUS(uss);
    } catch (error) {
      logError('Error updating US in repository: $error');
      return false;
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
