import 'package:f_testing_template/ui/pages/content/homeuc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/client.dart';
import '../../controllers/client_controller.dart';

class ClientDetailPage extends StatefulWidget {
  const ClientDetailPage({Key? key}) : super(key: key);

  @override
  _ClientDetailPageState createState() => _ClientDetailPageState();
}

class _ClientDetailPageState extends State<ClientDetailPage> {
  late Client client;
  final controllerName = TextEditingController();
  final controllerId = TextEditingController();

  @override
  void initState() {
    super.initState();
    client =
        Get.arguments[0]; // Inicializar us con los argumentos de Get.arguments
    controllerName.text = client.name;
    controllerId.text = client.id;
  }

  @override
  Widget build(BuildContext context) {
    ClientController clientController = Get.find();
    controllerName.text = client.name;
    controllerId.text = client.id;
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
        title: Text(client.name),
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
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                key: const Key('TextFieldId'),
                controller: controllerId,
                decoration: const InputDecoration(
                  labelText: 'Id',
                )),
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
                            Client clientM = client;
                            clientM.name = controllerName.text;
                            clientM.id = controllerId.text;
                            await clientController.updateClient(clientM);
                            Get.to(() => HomePageUC(
                                  key: const Key('HomePageUC'),
                                  loggedEmail: '',
                                  loggedPassword: '',
                                ));
                          },
                          child: const Text("Save")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
