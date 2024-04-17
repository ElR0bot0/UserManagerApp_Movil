import 'package:loggy/loggy.dart';

import '../../../domain/entities/us.dart';


class USLocalDataSource {
  List<US> uSs = <US>[];
  addUS(US us) {
    logInfo("Local data source adding US");
    uSs.add(us);
  }

  Future<List<US>> getAllUSs() async {
    logInfo("Local data returning getAllUSs " + uSs.length.toString());
    return uSs;
  }

  Future<void> deleteUS(id) async {
    uSs.removeWhere((element) => element.id == id);
  }

  Future<void> updateUS(usi) async {
    US oldUS = uSs.singleWhere((element) => element.id == usi.id);
    uSs[uSs.indexOf(oldUS)] = usi;
  }
}
