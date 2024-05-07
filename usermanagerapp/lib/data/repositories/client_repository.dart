import 'package:loggy/loggy.dart';
import '../../domain/entities/client.dart';
import '../datasources/remote/client_remote_datasource.dart';

class ClientRepository {
  late ClientRemoteDataSource _ClientDatatasource;

  ClientRepository() {
    logInfo("Starting ClientRepository");
    _ClientDatatasource = ClientRemoteDataSource();
  }

  Future<bool> addClient(Client clienti) async {
    try {
      await _ClientDatatasource.addClient(clienti);
      return true;
    } catch (error) {
      logError('Error adding Client in repository: $error');
      return false;
    }
  }

  Future<List<Client>> getAllClients() async {
    try {
      return await _ClientDatatasource.getAllClients();
    } catch (error) {
      logError('Error getting all Clients in repository: $error');
      return [];
    }
  }

  Future<void> deleteClient(String id) async {
    try {
      await _ClientDatatasource.deleteClient(id);
    } catch (error) {
      logError('Error deleting Client in repository: $error');
    }
  }

  Future<void> updateClient(Client clients) async {
    try {
      await _ClientDatatasource.updateClient(clients);
    } catch (error) {
      logError('Error updating Client in repository: $error');
    }
  }

  Future<Client?> getClientById(String id) async {
    try {
      return await _ClientDatatasource.getClientById(id);
    } catch (error) {
      logError('Error getting Client by ID in repository: $error');
      return null;
    }
  }

  Future<Client?> getClientByEmail(String email) async {
    try {
      return await _ClientDatatasource.getClientByEmail(email);
    } catch (error) {
      logError('Error getting Client by Email in repository: $error');
      return null;
    }
  }
}
