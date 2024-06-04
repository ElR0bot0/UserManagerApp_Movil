import 'package:f_testing_template/domain/repositories/iucrepository.dart';

class UCs {
  final IUCRepository _repository;
  UCs(this._repository);
  Future<bool> authenticateUC(String email, String password) async =>
      await _repository.authenticateUC(email, password);
}
