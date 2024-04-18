import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/report.dart';
import '../controllers/report_controller.dart';
import '../pages/content/report_detail_page.dart';

class ListItemReport extends StatelessWidget {
  final Report report;
  const ListItemReport(this.report, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    String desc = "Support User: " + report.us.name + " | Client: " + report.client.name;
    logInfo("ListItem for report " + report.problem.toString());
    ReportController reportController = Get.find();
    String? id = report.id.toString();
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
          reportController.deleteReport(report.id);
        },
        child: Card(
          key: Key('reportItem' + id),
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
                  title: Text(report.problem),
                  subtitle:  Text(desc),
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => ReportDetailPage(
                key: const Key('ReportDetailPage')
              ), arguments: [report, report.id]);
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
