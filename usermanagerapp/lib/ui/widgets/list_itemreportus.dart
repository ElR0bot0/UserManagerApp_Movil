import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import '../../domain/entities/report.dart';
import '../controllers/report_controller.dart';
import '../controllers/us_controller.dart';
import '../pages/content/report_detail_pageus.dart';

class ListItemReportUS extends StatelessWidget {
  final Report report;
  const ListItemReportUS(this.report, {Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    String desc = "Support User ID: " + report.usid.toString() + " | Client ID: " + report.clientid.toString();
    logInfo("ListItem for report " + report.problem.toString());
    ReportController reportController = Get.find();
    USController usController = Get.find();
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
        onDismissed: (direction) async {
  try {
    // Remove the item from the data source.
    await reportController.deleteReport(report.id.toString());
    var currentus = usController.uss.firstWhere((us) => us.id == report.usid.toString());
    currentus.reportquantity--;
    await usController.updateUS(currentus);
  } catch (error) {
    print('Error deleting report: $error');
  }
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
                  Get.to(() => ReportDetailPageUS(
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