import 'package:get/get.dart';

import '../../data/repositories/us_repository.dart';
import '../entities/us.dart';

class USs {
  final USRepository _repository = Get.find();
  USs(find);

  Future<void> addUS(usi) async => await _repository.addUS(usi);

  Future<List<US>> getAllUSs() async => await _repository.getAllUSs();

  Future<void> deleteUS(id) async => await _repository.deleteUS(id);

  Future<void> updateUS(usi) async => await _repository.updateUS(usi);

  Future<bool> authenticateUS(String email, String password) async => await _repository.authenticateUS(email, password);

  Future<US?> getUSById(String id) async {
    try {
      return await _repository.getUSById(id);
    } catch (error) {
      print('Error getting US by ID in USs class: $error');
      return null;
    }
  }

}