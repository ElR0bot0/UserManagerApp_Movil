import 'package:f_testing_template/ui/controllers/uc_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/us_controller.dart';
import '../content/homeuc.dart';
import '../content/homeus.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.email, required this.password})
      : super(key: key);

  final String email;
  final String password;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool useHomePageUS = false; // State variable to track the toggle state

  @override
  Widget build(BuildContext context) {
    UCController ucController = Get.find();
    USController usController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 12.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  key: const Key('TextFormFieldLoginEmail'),
                  controller: _emailController,
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
                  key: const Key('TextFormFieldLoginPassword'),
                  controller: _passwordController,
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
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  key: const Key('ButtonLoginSubmit'),
                  onPressed: () async {
                    bool isuc = await ucController.authenticateUC(_emailController.text, _passwordController.text);
                    bool isus = await usController.authenticateUS(_emailController.text, _passwordController.text);
                    if (isuc) {
                      Get.offAll(() => HomePageUC(
                        key: const Key('HomePageUC'),
                        loggedEmail: _emailController.text,
                        loggedPassword: _passwordController.text,
                      ));
                    } else {
                      if(isus){                       
                        try{
                          Get.offAll(() => HomePageUS(
                          key: const Key('HomePageUS'),
                          loggedEmail: _emailController.text,
                          loggedPassword: _passwordController.text,
                        ));
                        } catch (e) {
                          print(e);
                        }
                      } else { // Mostrar un mensaje de error al usuario
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Wrong email or password'),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Submit"),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
