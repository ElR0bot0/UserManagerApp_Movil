import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/client_controller.dart';
import '../../controllers/us_controller.dart';
import '../../widgets/list_item.dart';
import '../../widgets/list_itemus.dart';
import '../authentication/createus.dart';
import '../authentication/login.dart';
import '../authentication/createclient.dart';

class Report {
  final String title;
  final String client;
  final int rating;
  final String description;

  Report({
    required this.title,
    required this.client,
    required this.rating,
    required this.description,
  });
}

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
              SizedBox(height: 20),
              _buildReportList(),
              SizedBox(height: 20),
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

  Widget _buildReportList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return _buildReportItem(index);
      },
    );
  }

  Widget _buildReportItem(int index) {
    Report report = reports[index];

    return ListTile(
      title: Text(report.title),
      subtitle: Text("Client: ${report.client} | Rating: ${report.rating}"),
      trailing: TextButton(
        onPressed: () {
          _showReportDetails(context, report);
        },
        child: Text("Details"),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController clientController = TextEditingController();
    TextEditingController ratingController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Report Problem'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: clientController,
                  decoration: InputDecoration(labelText: 'Client'),
                ),
                TextField(
                  controller: ratingController,
                  decoration: InputDecoration(labelText: 'Rating'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(labelText: 'Description'),
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
              onPressed: () {
                String title = titleController.text;
                String client = clientController.text;
                int rating = int.tryParse(ratingController.text) ?? 0;
                String description = descriptionController.text;

                if (title.isNotEmpty && client.isNotEmpty) {
                  setState(() {
                    reports.add(
                      Report(
                        title: title,
                        client: client,
                        rating: rating,
                        description: description,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                } else {
                  // Show validation message
                  // For example, a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
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

  void _showReportDetails(BuildContext context, Report report) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(report.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Client: ${report.client}"),
              Text("Rating: ${report.rating}"),
              SizedBox(height: 10),
              Text("Description:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(report.description),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
