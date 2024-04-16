import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/list_item.dart';
import '../authentication/login.dart';
import '../authentication/signup.dart';
import 'detail.dart';

class HomePageUC extends StatelessWidget {
  const HomePageUC(
      {Key? key, required this.loggedEmail, required this.loggedPassword})
      : super(key: key);
  final String loggedEmail;
  final String loggedPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coordinator Menu"),
        actions: [
          IconButton(
              key: const Key('ButtonHomeLogOff'),
              onPressed: () {
                Get.off(() => LoginScreen(
                      key: const Key('LoginScreen'),
                      email: loggedEmail,
                      password: loggedPassword,
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
            floatingActionButton: FloatingActionButton(
        key: const Key('addUserButton'),
        child: Icon(Icons.add),
        onPressed: () {
          Get.off(() => SignUpPage(
                      key: const Key('SignUpPage'),
                    ));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _listView(),
      ),
    );
  }

  Widget _listView() {
    // Aquí iría el ListView.builder para mostrar la lista de usuarios
    return ListView.builder(
      itemCount: 5,  // Número de elementos de ejemplo
      itemBuilder: (context, index) {
        // Aquí se crean y retornan los elementos del ListView
        return ListItem();  // Aquí iría la lógica para construir un ListItem con datos del usuario
      },
    );
  }
}
