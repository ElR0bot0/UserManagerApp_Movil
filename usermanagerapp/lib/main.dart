import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/i_client_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/i_report_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/i_uc_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/i_us_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/report_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/uc_remote_datasource.dart';
import 'package:f_testing_template/data/datasources/remote/us_remote_datasource.dart';
import 'package:f_testing_template/data/repositories/uc_repository.dart';
import 'package:f_testing_template/domain/repositories/iclientrepository.dart';
import 'package:f_testing_template/domain/repositories/ireportrepository.dart';
import 'package:f_testing_template/domain/repositories/iucrepository.dart';
import 'package:f_testing_template/domain/repositories/iusrepository.dart';
import 'package:f_testing_template/domain/use_case/ucs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/repositories/client_repository.dart';
import 'data/repositories/report_repository.dart';
import 'data/repositories/us_repository.dart';
import 'domain/use_case/clientss.dart';
import 'domain/use_case/reports.dart';
import 'domain/use_case/uss.dart';
import 'ui/controllers/client_controller.dart';
import 'ui/controllers/report_controller.dart';
import 'ui/controllers/uc_controller.dart';
import 'ui/controllers/us_controller.dart';
import 'ui/pages/authentication/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  print("Registering IClientRemoteDataSource");
  Get.put<IClientRemoteDataSource>(ClientRemoteDataSource());

  print("Registering IClientRepository");
  Get.put<IClientRepository>(
      ClientRepository(Get.find<IClientRemoteDataSource>()));

  print("Registering Clientss");
  Get.put(Clientss(Get.find<IClientRepository>()));

  print("Registering ClientController");
  Get.put<ClientController>(
      ClientController(clientUseCase: Get.find<Clientss>()));

  print("Registering IUSRemoteDataSource");
  Get.put<IUSRemoteDataSource>(USRemoteDataSource());

  print("Registering IUSRepository");
  Get.put<IUSRepository>(USRepository(Get.find<IUSRemoteDataSource>()));

  print("Registering USs");
  Get.put(USs(Get.find<IUSRepository>()));

  print("Registering USController");
  Get.put<USController>(USController(usUseCase: Get.find<USs>()));

  print("Registering IReportRemoteDataSource");
  Get.put<IReportRemoteDataSource>(ReportRemoteDataSource());

  print("Registering IReportRepository");
  Get.put<IReportRepository>(
      ReportRepository(Get.find<IReportRemoteDataSource>()));

  print("Registering Reportss");
  Get.put(Reportss(Get.find<IReportRepository>()));

  print("Registering ReportController");
  Get.put<ReportController>(
      ReportController(reportUseCase: Get.find<Reportss>()));

  print("Registering IUCRemoteDatasource");
  Get.put<IUCRemoteDatasource>(UCRemoteDatasource());

  print("Registering IUCRepository");
  Get.put<IUCRepository>(UCRepository(Get.find<IUCRemoteDatasource>()));

  print("Registering UCs");
  Get.put(UCs(Get.find<IUCRepository>()));

  print("Registering UCController");
  Get.put<UCController>(UCController(ucUseCase: Get.find<UCs>()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'User Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(
        key: Key('LoginScreen'),
        email: "blank",
        password: "blank",
      ),
    );
  }
}
