import 'package:loggy/loggy.dart';

import '../../../domain/entities/client.dart';

class ClientLocalDataSource {
  List<Client> clients = <Client>[];
  addClient(Client client) {
    logInfo("Local data source adding Client");
    clients.add(client);
  }

  Future<List<Client>> getAllClients() async {
    logInfo("Local data returning getAllClients " + clients.length.toString());
    return clients;
  }

  Future<void> deleteClient(id) async {
    clients.removeWhere((element) => element.id == id);
  }

  Future<void> updateClient(cliente) async {
    Client oldClient = clients.singleWhere((element) => element.id == cliente.id);

    clients[clients.indexOf(oldClient)] = cliente;
  }
}
