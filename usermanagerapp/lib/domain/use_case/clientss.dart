import 'package:get/get.dart';
import '../../data/repositories/client_repository.dart';
import '../entities/client.dart';

class Clientss {
  final ClientRepository _repository = Get.find();
  Clientss(find);
  Future<void> addClient(Client) async => await _repository.addClient(Client);
  Future<List<Client>> getAllClients() async => await _repository.getAllClients();
  Future<void> deleteClient(id) async => await _repository.deleteClient(id);
  Future<void> updateClient(Client) async => await _repository.updateClient(Client);
}