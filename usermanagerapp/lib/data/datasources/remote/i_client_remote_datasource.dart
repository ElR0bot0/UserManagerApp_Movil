import '../../../domain/entities/client.dart';

abstract class IClientRemoteDataSource {
  Future<void> addClient(Client client);
  Future<List<Client>> getAllClients();
  Future<void> deleteClient(String id);
  Future<void> updateClient(Client client);
  Future<Client?> getClientById(String id);
  Future<Client?> getClientByEmail(String email);
}
