import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/client.dart';
import '../../controllers/client_controller.dart';
import '../content/homeuc.dart';

class CreateClient extends StatefulWidget {
  const CreateClient({Key? key}) : super(key: key);

  @override
  State<CreateClient> createState() => _CreateClientPageState();
}

class _CreateClientPageState extends State<CreateClient> {
  final _formKey = GlobalKey<FormState>();
  final idcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  @override
  // ignore: override_on_non_overriding_member
  ClientController clientController = Get.find();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          key: const Key('BackButton'),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => HomePageUC(
                  key: const Key('HomePageUC'),
                  loggedEmail: '',
                  loggedPassword: '',
                ));
          },
        ),
        title: Text("Create new client account"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Enter account information',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldSignUpId'),
                  controller: idcontroller,
                  decoration: const InputDecoration(labelText: "ID"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter ID";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: const Key('TextFormFieldSignUpName'),
                  controller: namecontroller,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    key: const Key('ButtonSignUpSubmit'),
                    onPressed: () async {
                      Client client = Client(
                          id: idcontroller.text, name: namecontroller.text);
                      await clientController.addClient(client);
                      Get.to(() => HomePageUC(
                            key: const Key('HomePageUC'),
                            loggedEmail: '',
                            loggedPassword: '',
                          ));
                    },
                    child: const Text("Submit")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
