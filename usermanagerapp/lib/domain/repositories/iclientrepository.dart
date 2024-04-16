import '../entities/client.dart';

abstract class IClientRepository {
  Future<bool> getClient();
  Future<List<Client>> getAllClients();
  Future<void> deleteClient(id);
  Future<void> updateClient(user);
  Future<void> addClient(id);
}
