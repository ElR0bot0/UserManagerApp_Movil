import 'package:loggy/loggy.dart';

import '../../domain/entities/client.dart';
import '../datasources/local/client_local_datasource.dart';

class ClientRepository {

  late ClientLocalDataSource _clientDatatasource;

  ClientRepository() {
    logInfo("Starting ClientRepository");
    _clientDatatasource = ClientLocalDataSource();
  }

  Future<bool> addClient(Client client) async {
    await _clientDatatasource.addClient(client);
    return Future.value(true);
  } 

  Future<List<Client>> getAllClients() async => await _clientDatatasource.getAllClients();

  Future<void> deleteClient(id) async => await _clientDatatasource.deleteClient(id);

  Future<void> updateClient(client) async => await _clientDatatasource.updateClient(client);
}