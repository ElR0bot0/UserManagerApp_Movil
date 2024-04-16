import 'package:f_testing_template/domain/entities/client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/repositories/client_repository.dart';
import 'data/repositories/us_repository.dart';
import 'domain/repositories/iclientrepository.dart';
import 'domain/use_case/clientss.dart';
import 'domain/use_case/uss.dart';
import 'ui/controllers/client_controller.dart';
import 'ui/controllers/us_controller.dart';
import 'ui/pages/authentication/login.dart';

void main() {
  Get.put(ClientRepository());  // Registro de la implementación concreta ClientRepository
  Get.put(Clientss(Get.find<ClientRepository>()));  // Pasamos ClientRepository como argumento
  Get.put<ClientController>(ClientController(clientUseCase: Get.find<Clientss>()));  // Pasamos Clientss como argumento
  Get.put(USRepository());  // Registro de la implementación concreta ClientRepository
  Get.put(USs(Get.find<USRepository>()));  // Pasamos ClientRepository como argumento
  Get.put<USController>(USController(usUseCase: Get.find<USs>()));  // Pasamos Clientss como argumento
  runApp(MyApp());
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
