import 'package:loggy/loggy.dart';

import '../datasources/remote/uc_remote_datasource.dart';

class UCRepository {

  late UCRemoteDatasource _ucDatatasource;

  UCRepository() {
    logInfo("Starting UCRepository");
    _ucDatatasource = UCRemoteDatasource();
  }
  
  Future<bool> authenticateUC(String email, String password) async => await _ucDatatasource.authenticateUC(email, password);
}


