import 'package:loggy/loggy.dart';

import '../../domain/entities/us.dart';
import '../datasources/local/us_local_datasource.dart';


class USRepository {

  late USLocalDataSource _USDatatasource;

  USRepository() {
    logInfo("Starting USRepository");
    _USDatatasource = USLocalDataSource();
  }

  Future<bool> addUS(US usi) async {
    await _USDatatasource.addUS(usi);
    return Future.value(true);
  } 

  Future<List<US>> getAllUSs() async => await _USDatatasource.getAllUSs();

  Future<void> deleteUS(id) async => await _USDatatasource.deleteUS(id);

  Future<void> updateUS(uss) async => await _USDatatasource.updateUS(uss);
}