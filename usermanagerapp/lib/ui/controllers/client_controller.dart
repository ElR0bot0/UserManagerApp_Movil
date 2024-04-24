import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/client.dart';
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
    logInfo("ClientController -> add clienter");
    await clientUseCase.addClient(client);
    await getAllClients();
  }

  Future<void> getAllClients() async {
    var list = await clientUseCase.getAllClients();
    _clients.value = list;
    _clients.refresh();
  }

  Future<void> deleteClient(id) async {
    logInfo("ClientController -> delete clienter $id");
    await clientUseCase.deleteClient(id);
    await getAllClients();
  }

  Future<void> updateClient(client) async {
    logInfo("ClientController -> updateUser clienter ${client.id}");
    await clientUseCase.updateClient(client);
    await getAllClients();
  }

  Future<Client?> getClientById(String id) async {
    try {
      return await clientUseCase.getClientById(id);
    } catch (error) {
      logError('Error getting Client by ID in ClientController: $error');
      return null;
    }
  }

  Future<Client?> getClientByEmail(String email) async {
    try {
      return await clientUseCase.getClientByEmail(email);
    } catch (error) {
      logError('Error getting Client by Email in ClientController: $error');
      return null;
    }
  }
}
