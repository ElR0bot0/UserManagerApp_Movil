import 'package:loggy/loggy.dart';
import '../../domain/repositories/iucrepository.dart';
import '../datasources/remote/uc_remote_datasource.dart';

class UCRepository implements IUCRepository {
  late UCRemoteDatasource _ucDatatasource;

  UCRepository() {
    logInfo("Starting UCRepository");
    _ucDatatasource = UCRemoteDatasource();
  }

  @override
  Future<bool> authenticateUC(String email, String password) async {
    return await _ucDatatasource.authenticateUC(email, password);
  }
}