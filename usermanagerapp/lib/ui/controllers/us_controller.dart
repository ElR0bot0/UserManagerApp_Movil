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
    logInfo("USController -> getAllUsers got " + list.length.toString());
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
}