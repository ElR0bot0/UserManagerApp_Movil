import 'package:get/get.dart';

import '../../data/repositories/uc_repository.dart';

class UCs {
  final UCRepository _repository = Get.find();
  UCs(find);
  Future<bool> authenticateUC(String email, String password) async => await _repository.authenticateUC(email, password);
}