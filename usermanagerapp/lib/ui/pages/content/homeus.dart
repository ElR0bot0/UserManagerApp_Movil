import 'package:f_testing_template/ui/controllers/report_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/report.dart';
import '../../controllers/client_controller.dart';
import '../../controllers/us_controller.dart';
import '../../widgets/list_itemreportus.dart';
import '../authentication/login.dart';

class HomePageUS extends StatefulWidget {
  HomePageUS({
    Key? key,
    required this.loggedEmail,
    required this.loggedPassword,
  }) : super(key: key);
  final String loggedEmail;
  final String loggedPassword;

  @override
  State<HomePageUS> createState() => _HomePageUSState();
}

class _HomePageUSState extends State<HomePageUS> {
  ClientController clientController = Get.find();
  USController usController = Get.find();
  ReportController reportController = Get.find();
  List<Report> reports = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support Menu"),
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
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('ButtonReportProblem'),
        onPressed: () {
          _showReportDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getXlistView(),
            ],
          ),
        ),
      ),
    );
  }

Widget _getXlistView() {
final currentus = usController.uss.firstWhere((us) => us.email == widget.loggedEmail);
  final filteredReports = reportController.reports.where((report) => report.usid.toString() == currentus.id).toList();

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
      return ListItemReportUS(user);
    },
  );
}

void _showReportDialog(BuildContext context) {
  TextEditingController titleController = TextEditingController();
  TextEditingController clientController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      DateTime? selectedDate;
      TimeOfDay? selectedTime;

      return AlertDialog(
        title: const Text('Report Problem'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Problem'),
              ),
              TextField(
                controller: clientController,
                decoration: InputDecoration(labelText: 'Client'),
              ),
              TextField(
                controller: durationController,
                decoration: InputDecoration(labelText: 'Duration'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              SizedBox(height: 20), // Space between the last text field and the "Select Date" and "Select Time" buttons
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          selectedDate = pickedDate;
                        }
                      },
                      child: Text(selectedDate != null ? 'Selected Date: ${selectedDate!.toLocal().toString().split(' ')[0]}' : 'Select Date'),
                    ),
                    SizedBox(height: 10), // Additional space
                    ElevatedButton(
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          selectedTime = pickedTime;
                        }
                      },
                      child: Text(selectedTime != null ? 'Selected Time: ${selectedTime!.format(context)}' : 'Select Time'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              String title = titleController.text;
              String client = clientController.text;
              String description = descriptionController.text;
              String duration = durationController.text;
              if (title.isNotEmpty && client.isNotEmpty && description.isNotEmpty && duration.isNotEmpty && selectedDate != null && selectedTime != null) {
                final currentus = usController.uss.firstWhere((us) => us.email == widget.loggedEmail);
                DateTime reportDateTime = DateTime(
                  selectedDate!.year,
                  selectedDate!.month,
                  selectedDate!.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );
                Report newreport = Report(
                  problem: title,
                  clientid: int.parse(client),
                  desc: description,
                  duration: duration,
                  usid: int.parse(currentus.id), 
                  id: 0, 
                  rating: 0, 
                  startDate: reportDateTime,
                );
                await reportController.addReport(newreport);

                Navigator.of(context).pop();

                setState(() {});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please fill in all fields and select a date and time')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}


}
