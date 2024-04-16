import 'package:loggy/loggy.dart';

import '../../../domain/entities/client.dart';

class ClientLocalDataSource {
  List<Client> Clients = <Client>[];
  static int globalId = 0;
  addClient(Client Client) {
    logInfo("Local data source adding Client");
    Clients.add(Client);
  }

  Future<List<Client>> getAllClients() async {
    logInfo("Local data returning getAllClients " + Clients.length.toString());
    return Clients;
  }

  Future<void> deleteClient(id) async {
    Clients.removeWhere((element) => element.id == id);
  }

  Future<void> updateClient(Cliente) async {
    Client oldClient = Clients.singleWhere((element) => element.id == Cliente.id);

    Clients[Clients.indexOf(oldClient)] = Cliente;
  }
}
