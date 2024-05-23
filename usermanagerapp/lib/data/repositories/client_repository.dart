import 'package:loggy/loggy.dart';
import '../../domain/entities/client.dart';
import '../../domain/repositories/iclientrepository.dart';
import '../datasources/remote/client_remote_datasource.dart';

class ClientRepository implements IClientRepository {
  late ClientRemoteDataSource _clientDatasource;

  ClientRepository() {
    logInfo("Starting ClientRepository");
    _clientDatasource = ClientRemoteDataSource();
  }

  @override
  Future<bool> addClient(Client client) async {
    try {
      return await _clientDatasource.addClient(client);
    } catch (error) {
      logError('Error adding Client in repository: $error');
      return false;
    }
  }

  @override
  Future<List<Client>> getAllClients() async {
    try {
      return await _clientDatasource.getAllClients();
    } catch (error) {
      logError('Error getting all Clients in repository: $error');
      return [];
    }
  }

  @override
  Future<bool> deleteClient(String id) async {
    try {
      return await _clientDatasource.deleteClient(id);
    } catch (error) {
      logError('Error deleting Client in repository: $error');
      return false;
    }
  }

  @override
  Future<bool> updateClient(Client client) async {
    try {
      return await _clientDatasource.updateClient(client);
    } catch (error) {
      logError('Error updating Client in repository: $error');
      return false;
    }
  }

  @override
  Future<Client?> getClientById(String id) async {
    try {
      return await _clientDatasource.getClientById(id);
    } catch (error) {
      logError('Error getting Client by ID in repository: $error');
      return null;
    }
  }

  @override
  Future<Client?> getClientByEmail(String email) async {
    try {
      return await _clientDatasource.getClientByEmail(email);
    } catch (error) {
      logError('Error getting Client by Email in repository: $error');
      return null;
    }
  }
}
