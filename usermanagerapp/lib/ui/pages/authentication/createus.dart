import 'package:f_testing_template/ui/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/us.dart';
import '../../controllers/us_controller.dart';
import '../content/homeuc.dart';

class CreateUS extends StatefulWidget {
  const CreateUS({Key? key}) : super(key: key);

  @override
  State<CreateUS> createState() => _CreateUSState();
}

class _CreateUSState extends State<CreateUS> {
  final _formKey = GlobalKey<FormState>();
  final idcontroller = TextEditingController();
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  // ignore: override_on_non_overriding_member
  USController usController = Get.find();
  ReportController reportController = Get.find();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: Text("Create new support account"),
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
                TextFormField(
                  key: const Key('TextFormFieldSignUpEmail'),
                  controller: emailcontroller,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter email";
                    } else if (!value.contains('@')) {
                      return "Enter valid email address";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldSignUpPassword'),
                  controller: passwordcontroller,
                  decoration: const InputDecoration(labelText: "Password"),
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    } else if (value.length < 6) {
                      return "Password should have at least 6 characters";
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
                      US us = US(
                          id: idcontroller.text,
                          name: namecontroller.text,
                          email: emailcontroller.text,
                          password: passwordcontroller.text,
                          reportquantity: 0);
                      await usController.addUS(us);
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
