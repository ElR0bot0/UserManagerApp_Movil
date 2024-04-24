import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/report.dart';
import '../../controllers/client_controller.dart';
import '../../controllers/report_controller.dart';
import '../../controllers/us_controller.dart';
import '../../widgets/list_item.dart';
import '../../widgets/list_itemreport.dart';
import '../../widgets/list_itemus.dart';
import '../authentication/createus.dart';
import '../authentication/login.dart';
import '../authentication/createclient.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePageUC extends StatefulWidget {
  HomePageUC({
    Key? key,
    required this.loggedEmail,
    required this.loggedPassword,
  }) : super(key: key);
  final String loggedEmail;
  final String loggedPassword;

  @override
  State<HomePageUC> createState() => _HomePageUCState();
}

class _HomePageUCState extends State<HomePageUC> {
  ClientController clientController = Get.find();
  USController usController = Get.find();
  ReportController reportController = Get.find();
  late String selectedList;

  @override
  void initState() {
    super.initState();
    selectedList = 'Support users';
  }

    TextEditingController clientIdController = TextEditingController();
  TextEditingController usIdController = TextEditingController();

  List<Report> getFilteredReports() {
    if (selectedList != 'Reports') {
      return [];
    }

    String clientId = clientIdController.text;
    String usId = usIdController.text;

    return reportController.reports.where((report) {
      bool matchesClientId = clientId.isEmpty || report.clientid.toString() == clientId;
      bool matchesUsId = usId.isEmpty || report.usid.toString() == usId;
      return matchesClientId && matchesUsId;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coordinator Menu"),
        actions: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedList = 'Support users';
                  });
                },
                child: Text('Support Users'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedList == 'Support users'
                      ? Color(0xFFF7F2F9)
                      : Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedList = 'Clients';
                  });
                },
                child: Text('Clients'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedList == 'Clients' ? Color(0xFFF7F2F9) : Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedList = 'Reports';
                  });
                },
                child: Text('Reports'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedList == 'Reports' ? Color(0xFFF7F2F9) : Colors.grey,
                ),
              ),
            ],
          ),
          IconButton(
            key: const Key('ButtonHomeLogOff'),
            onPressed: () {
              Get.off(
                () => LoginScreen(
                  key: const Key('LoginScreen'),
                  email: widget.loggedEmail,
                  password: widget.loggedPassword,
                ),
              );
            },
            icon: const Icon(Icons.logout),
          )
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
              Get.off(
                () => CreateClient(
                  key: const Key('CreateClient'),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.support),
            backgroundColor: Color(0xFFd4cce4),
            label: 'Support user',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Get.off(
                () => CreateUS(
                  key: const Key('CreateUS'),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: selectedList == 'Clients'
            ? _getXlistView2()
            : selectedList == 'Support users'
                ? _getXlistView()
                : _getXlistView3(), // Añade tu contenido de informes aquí
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

 Widget _getXlistView3() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: clientIdController,
                decoration: InputDecoration(labelText: 'ClientID'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                controller: usIdController,
                decoration: InputDecoration(labelText: 'USID'),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {});
              },
              child: Text('Apply'),
            ),
          ],
        ),
        SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: getFilteredReports().length,
            itemBuilder: (context, index) {
              final user = getFilteredReports()[index];
              return ListItemReport(user);
            },
          ),
        ),
      ],
    );
  }
}
