import 'package:loggy/loggy.dart';

import '../../../domain/entities/us.dart';


class USLocalDataSource {
  List<US> USs = <US>[];
  static int globalId = 0;
  addUS(US us) {
    logInfo("Local data source adding US");
    USs.add(us);
  }

  Future<List<US>> getAllUSs() async {
    logInfo("Local data returning getAllUSs " + USs.length.toString());
    return USs;
  }

  Future<void> deleteUS(id) async {
    USs.removeWhere((element) => element.id == id);
  }

  Future<void> updateUS(USi) async {
    US oldUS = USs.singleWhere((element) => element.id == USi.id);

    USs[USs.indexOf(oldUS)] = USi;
  }
}
