import 'package:loggy/loggy.dart';

import '../../domain/entities/us.dart';
import '../datasources/local/us_local_datasource.dart';


class USRepository {

  late USLocalDataSource _uSDatatasource;

  USRepository() {
    logInfo("Starting USRepository");
    _uSDatatasource = USLocalDataSource();
  }

  Future<bool> addUS(US usi) async {
    await _uSDatatasource.addUS(usi);
    return Future.value(true);
  } 

  Future<List<US>> getAllUSs() async => await _uSDatatasource.getAllUSs();

  Future<void> deleteUS(id) async => await _uSDatatasource.deleteUS(id);

  Future<void> updateUS(uss) async => await _uSDatatasource.updateUS(uss);
}