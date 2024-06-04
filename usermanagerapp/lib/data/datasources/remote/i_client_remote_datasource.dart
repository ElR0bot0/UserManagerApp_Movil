import '../../../domain/entities/client.dart';

abstract class IClientRemoteDataSource {
  Future<bool> addClient(Client client);
  Future<List<Client>> getAllClients();
  Future<bool> deleteClient(String id);
  Future<bool> updateClient(Client client);
  Future<Client?> getClientById(String id);
  Future<Client?> getClientByEmail(String email);
}
