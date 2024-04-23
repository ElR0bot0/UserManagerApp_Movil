import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/client_controller.dart';
import '../../controllers/us_controller.dart';
import '../../widgets/list_item.dart';
import '../../widgets/list_itemus.dart';
import '../authentication/createus.dart';
import '../authentication/login.dart';
import '../authentication/createclient.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class HomePageUC extends StatefulWidget {
  HomePageUC(
      {Key? key, required this.loggedEmail, required this.loggedPassword})
      : super(key: key);
  final String loggedEmail;
  final String loggedPassword;

  @override
  State<HomePageUC> createState() => _HomePageUCState();
}

class _HomePageUCState extends State<HomePageUC> {
  ClientController clientController = Get.find();

  USController usController = Get.find();

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
                      email: widget.loggedEmail,
                      password: widget.loggedPassword,
                    ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
floatingActionButton: SpeedDial(
  icon: Icons.add,
  activeIcon: Icons.close,
  animatedIconTheme: IconThemeData(size: 22.0),
  overlayColor: Colors.black,
  overlayOpacity: 0.5,
  children: [
    SpeedDialChild(
      child: Icon(Icons.person),
      backgroundColor: Color(0xFFd4cce4),
      label: 'Client',
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () {
        Get.off(() => CreateClient(
          key: const Key('CreateClient')// puedes pasar un parámetro para identificar el tipo de usuario
        ));
      },
    ),
    SpeedDialChild(
      child: Icon(Icons.support),
      backgroundColor: Color(0xFFd4cce4),
      label: 'Support user',
      labelStyle: TextStyle(fontSize: 18.0),
      onTap: () {
        Get.off(() => CreateUS(
          key: const Key('CreateUS') // puedes pasar un parámetro para identificar el tipo de usuario
        ));
      },
    ),
  ],
)
,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getXlistView(),
              SizedBox(height: 0),  // Espacio entre los dos ListView
              _getXlistView2(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getXlistView2() {
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: clientController.clients.length,
        itemBuilder: (context, index) {
          final user = clientController.clients[index];
          return ListItem(user);
        },
      ),
    );
  }

  Widget _getXlistView() {
    print(usController.uss.length);
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: usController.uss.length,
        itemBuilder: (context, index) {
          final user = usController.uss[index];
          return ListItemUS(user);
        },
      ),
    );
  }
}
