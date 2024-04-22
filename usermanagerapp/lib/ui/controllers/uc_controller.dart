import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/use_case/ucs.dart';

class UCController extends GetxController {
  UCController({required this.ucUseCase});
  UCs ucUseCase;

  Future<bool> authenticateUC(String email, String password) async {
    logInfo("UCController -> add ucer");
    return await ucUseCase.authenticateUC(email, password);
  }
}