import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/us.dart';
import '../controllers/us_controller.dart';
import '../pages/content/us_detail_page';

class ListItemUS extends StatelessWidget {
  final US us;
  const ListItemUS(this.us, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logInfo("ListItem for us " + us.name.toString());
    USController usController = Get.find();
    String id = us.id;
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
          usController.deleteUS(us.id);
        },
        child: Card(
          key: Key('usItem' + id),
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
                  title: Text(us.name),
                  subtitle: const Text("Support User"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.off(() => USDetailPage(
                key: const Key('USDetailPage')
              ), arguments: [us, us.id]);
                },
                child: const Text("more"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
