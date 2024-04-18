import 'package:f_testing_template/ui/controllers/report_controller.dart';
import 'package:f_testing_template/ui/pages/content/homeuc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/client.dart';
import '../../controllers/client_controller.dart';
import '../../widgets/list_itemreport.dart';

class ClientReports extends StatefulWidget {
  ClientReports({
    Key? key,
    required this.selectedClient,
  }) : super(key: key);
  
  final Client selectedClient;

  @override
  _ClientReportsState createState() => _ClientReportsState();
}

class _ClientReportsState extends State<ClientReports> {
  ClientController clientController = Get.find();
  ReportController reportController = Get.find();
  late Client _selectedClient;

  @override
  void initState() {
    super.initState();
    _selectedClient = widget.selectedClient;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(() => HomePageUC(
              key: const Key('HomePageUC'), loggedEmail: '', loggedPassword: '',
            ));
          },
        ),
        title: Text(_selectedClient.name + "'s Reports"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getXlistView(),
              SizedBox(height: 0),
            ],
          ),
        ),
      ),
    );
  }

Widget _getXlistView() {
  final filteredReports = reportController.reports.where((report) => report.client == _selectedClient).toList();

  if (filteredReports.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.report_off, // Puedes cambiar este icono a cualquier otro que prefieras
            size: 50,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'There are no reports to show',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  return ListView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: filteredReports.length,
    itemBuilder: (context, index) {
      final user = filteredReports[index];
      return ListItemReport(user);
    },
  );
}
}
