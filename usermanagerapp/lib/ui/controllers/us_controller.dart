import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/us.dart';
import '../../domain/use_case/uss.dart';

class USController extends GetxController {
  final RxList<US> _uss = <US>[].obs;
  USController({required this.usUseCase});
  USs usUseCase;

  List<US> get uss => _uss;

  @override
  onInit() {
    super.onInit();
    getAllUSs();
  }

  Future<void> addUS(us) async {
    logInfo("USController -> add user");
    await usUseCase.addUS(us);
    await getAllUSs();
  }

  Future<void> getAllUSs() async {
    var list = await usUseCase.getAllUSs();
    _uss.value = list;
    _uss.refresh();
  }

  Future<void> deleteUS(id) async {
    logInfo("USController -> delete user $id");
    await usUseCase.deleteUS(id);
    await getAllUSs();
  }

  Future<void> updateUS(us) async {
    logInfo("USController -> updateUser user ${us.id}");
    await usUseCase.updateUS(us);
    await getAllUSs();
  }

  Future<bool> authenticateUS(String email, String password) async {
    logInfo("USController -> add user");
    return await usUseCase.authenticateUS(email, password);
  }

  Future<US?> getUSById(String id) async {
    try {
      return await usUseCase.getUSById(id);
    } catch (error) {
      logError('Error getting US by ID in USController: $error');
      return null;
    }
  }

    Future<US?> getUSByEmail(String email) async {
    try {
      return await usUseCase.getUSByEmail(email);
    } catch (error) {
      logError('Error getting US by email in USController: $error');
      return null;
    }
  }
}