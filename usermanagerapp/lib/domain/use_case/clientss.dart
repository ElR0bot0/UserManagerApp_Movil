import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../data/repositories/client_repository.dart';
import '../entities/client.dart';

class Clientss {
  final ClientRepository _repository = Get.find();
  Clientss(find);

  Future<bool> addClient(clienti) async => await _repository.addClient(clienti);

  Future<List<Client>> getAllClients() async =>
      await _repository.getAllClients();

  Future<bool> deleteClient(id) async => await _repository.deleteClient(id);

  Future<bool> updateClient(clienti) async =>
      await _repository.updateClient(clienti);

  Future<Client?> getClientById(String id) async {
    try {
      return await _repository.getClientById(id);
    } catch (error) {
      if (kDebugMode) {
        print('Error getting Client by ID in Clients class: $error');
      }
      return null;
    }
  }

  Future<Client?> getClientByEmail(String email) async {
    try {
      return await _repository.getClientByEmail(email);
    } catch (error) {
      if (kDebugMode) {
        print('Error getting Client by Email in Clients class: $error');
      }
      return null;
    }
  }
}
