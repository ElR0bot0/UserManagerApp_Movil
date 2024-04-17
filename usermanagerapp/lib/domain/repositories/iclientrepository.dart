import '../entities/client.dart';

abstract class IClientRepository {
  Future<bool> getClient();
  Future<List<Client>> getAllClients();
  Future<void> deleteClient(id);
  Future<void> updateClient(client);
  Future<void> addClient(id);
}
