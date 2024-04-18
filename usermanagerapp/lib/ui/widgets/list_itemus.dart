import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/us.dart';
import '../controllers/us_controller.dart';
import '../pages/content/us_detail_page';
import '../pages/content/usreports.dart';

class ListItemUS extends StatelessWidget {
  final US us;
  const ListItemUS(this.us, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logInfo("ListItem for us " + us.name.toString());
    USController usController = Get.find();
    String id = us.id;
    String desc = "Support User | # of Reports: " + us.reportquantity.toString();
    if (us.ratings.isNotEmpty) {
      desc = desc + "| Avg Rating: "+us.avgrating.toStringAsFixed(1) +"⭐";
    }
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
                  subtitle: Text(desc),
                ),
              ),
                            TextButton(
                onPressed: () {
                  Get.off(() => USReports(
                key: const Key('USReports'), selectedUS: us,
              ));
                },
                child: const Text("Reports"),
              ),
              TextButton(
                onPressed: () {
                  Get.off(() => USDetailPage(
                key: const Key('USDetailPage')
              ), arguments: [us, us.id]);
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
