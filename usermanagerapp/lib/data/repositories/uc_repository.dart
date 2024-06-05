import 'package:f_testing_template/data/datasources/remote/i_uc_remote_datasource.dart';

import '../../domain/repositories/iucrepository.dart';

class UCRepository implements IUCRepository {
  final IUCRemoteDatasource _ucDatatasource;

  UCRepository(this._ucDatatasource);

  @override
  Future<bool> authenticateUC(String email, String password) async {
    return await _ucDatatasource.authenticateUC(email, password);
  }
}
