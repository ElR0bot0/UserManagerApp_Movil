import 'package:f_testing_template/ui/pages/content/homeuc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/us.dart';
import '../../controllers/us_controller.dart';

class USDetailPage extends StatefulWidget {
  const USDetailPage({Key? key}) : super(key: key);

  @override
  _USDetailPageState createState() => _USDetailPageState();
}

class _USDetailPageState extends State<USDetailPage> {
  late US us; // Declarar como late para inicializar en initState

  final controllerName = TextEditingController();
  final controllerId = TextEditingController();
  final controlleremail = TextEditingController();
  final controllerpassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    us = Get.arguments[0]
        as US; // Inicializar us con los argumentos de Get.arguments
    controllerName.text = us.name;
    controllerId.text = us.id;
    controlleremail.text = us.email;
    controllerpassword.text = us.password;
  }

  @override
  Widget build(BuildContext context) {
    USController usController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => HomePageUC(
                  key: const Key('HomePageUC'),
                  loggedEmail: '',
                  loggedPassword: '',
                ));
          },
        ),
        title: Text(us.name), // Ahora us.name debería funcionar correctamente
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              key: const Key('TextFieldId'),
              controller: controllerId,
              decoration: const InputDecoration(
                labelText: 'Id',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: controlleremail,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: controllerpassword,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        US usM = us;
                        usM.name = controllerName.text;
                        usM.id = controllerId.text;
                        usM.email = controlleremail.text;
                        usM.password = controllerpassword.text;
                        await usController.updateUS(usM);
                        Get.to(() => HomePageUC(
                              key: const Key('HomePageUC'),
                              loggedEmail: '',
                              loggedPassword: '',
                            ));
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
