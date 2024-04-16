import 'dart:html';
import 'package:f_testing_template/domain/entities/client.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/use_case/clientss.dart';

class ClientController extends GetxController {
  final RxList<Client> _clients = <Client>[].obs;
  ClientController({required this.clientUseCase});
  Clientss clientUseCase;

  List<Client> get clients => _clients;

  @override
  onInit() {
    super.onInit();
    getAllClients();
  }

  Future<void> addClient(client) async {
    logInfo("ClientController -> add user");
    await clientUseCase.addClient(client);
    await getAllClients();
  }

  Future<void> getAllClients() async {
    var list = await clientUseCase.getAllClients();
    logInfo("ClientController -> getAllUsers got " + list.length.toString());
    _clients.value = list;
    _clients.refresh();
  }

  Future<void> deleteClient(id) async {
    logInfo("ClientController -> delete user $id");
    await clientUseCase.deleteClient(id);
    await getAllClients();
  }

  Future<void> updateClient(client) async {
    logInfo("ClientController -> updateUser user ${client.id}");
    await clientUseCase.updateClient(client);
    await getAllClients();
  }
}
