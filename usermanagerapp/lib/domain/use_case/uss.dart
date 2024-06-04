import 'package:f_testing_template/domain/repositories/iusrepository.dart';
import '../entities/us.dart';

class USs {
  final IUSRepository _repository;
  USs(this._repository);

  Future<bool> addUS(usi) async => await _repository.addUS(usi);

  Future<List<US>> getAllUSs() async => await _repository.getAllUSs();

  Future<bool> deleteUS(id) async => await _repository.deleteUS(id);

  Future<bool> updateUS(usi) async => await _repository.updateUS(usi);

  Future<bool> authenticateUS(String email, String password) async =>
      await _repository.authenticateUS(email, password);

  Future<US?> getUSById(String id) async {
    try {
      return await _repository.getUSById(id);
    } catch (error) {
      print('Error getting US by ID in USs class: $error');
      return null;
    }
  }
}
