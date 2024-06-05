import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/client.dart';
import '../controllers/client_controller.dart';
import '../pages/content/client_detail_page.dart';
import '../pages/content/clientreports.dart';

class ListItem extends StatelessWidget {
  final Client client;
  const ListItem(this.client, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logInfo("ListItem for client " + client.name.toString());
    ClientController clientController = Get.find();
    String id = client.id;
    return Center(
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Deleting",
                style: TextStyle(color: Colors.white),
              ),
            )),
        onDismissed: (direction) {
          // Remove the item from the data source.
          clientController.deleteClient(client.id);
        },
        child: Card(
          key: Key('clientItem' + id),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListTile(
                  // leading: CircleAvatar(
                  //   radius: 30.0,
                  //   backgroundColor: Colors.transparent,
                  //   child: ClipOval(child: Image.network(user.picture)),
                  // ),
                  title: Text(client.name),
                  subtitle: const Text("Client"),
                ),
              ),
              TextButton(
                key: const ValueKey('ClientReports_Button'),
                onPressed: () {
                  Get.to(() => ClientReports(
                        key: const Key('ClientReports'),
                        selectedClient: client,
                      ));
                },
                child: const Text("Reports"),
              ),
              TextButton(
                key: const ValueKey('ClientDetail_Button'),
                onPressed: () {
                  Get.to(
                      () =>
                          const ClientDetailPage(key: Key('ClientDetailPage')),
                      arguments: [client]);
                },
                child: const Text("Edit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
