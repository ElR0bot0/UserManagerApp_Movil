import 'package:loggy/loggy.dart';

import '../../domain/entities/client.dart';
import '../datasources/local/client_local_datasource.dart';

class ClientRepository {

  late ClientLocalDataSource _ClientDatatasource;

  ClientRepository() {
    logInfo("Starting ClientRepository");
    _ClientDatatasource = ClientLocalDataSource();
  }

  Future<bool> addClient(Client client) async {
    await _ClientDatatasource.addClient(client);
    return Future.value(true);
  } 

  Future<List<Client>> getAllClients() async => await _ClientDatatasource.getAllClients();

  Future<void> deleteClient(id) async => await _ClientDatatasource.deleteClient(id);

  Future<void> updateClient(Client) async => await _ClientDatatasource.updateClient(Client);
}