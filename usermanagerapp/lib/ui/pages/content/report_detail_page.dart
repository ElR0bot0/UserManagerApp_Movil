import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/report.dart';
import '../../controllers/report_controller.dart';

class ReportDetailPage extends StatefulWidget {
  const ReportDetailPage({Key? key}) : super(key: key);

  @override
  _ReportDetailPageState createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  late Report report;
  final controllerClient = TextEditingController();
  final controllerUS = TextEditingController();
  final controllerProblem = TextEditingController();
  final controllerDesc = TextEditingController();
  final controllerDuration = TextEditingController();
  final controllerRating = TextEditingController();
  final controllerStartDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    report = Get.arguments[0];
    controllerClient.text = report.client.name;
    controllerUS.text = report.us.name;
    controllerProblem.text = report.problem;
    controllerDesc.text = report.desc;
    controllerDuration.text = report.duration;
    controllerRating.text = report.rating?.toString() ?? '';
    controllerStartDate.text = report.startDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    ReportController reportController = Get.find();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('Report Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTextField(controllerProblem, 'Problem'),
              const SizedBox(
                height: 20,
              ),
              buildTextField(controllerDesc, 'Description'),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: buildTextField(controllerUS, 'US'),
                  ),
                  Flexible(
                    child: buildTextField(controllerClient, 'Client'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: buildTextField(controllerDuration, 'Duration'),
                  ),
                  Flexible(
                    child: buildTextField(controllerStartDate, 'Start Date'),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              buildRatingStars(controllerRating),
              ElevatedButton(
                  onPressed: () {
                    // Implementar la funcionalidad para calificar el reporte aquí
                  },
                  child: Text('Rate this report'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: '',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          readOnly: true,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildRatingStars(TextEditingController controller) {
    int rating = int.tryParse(controller.text) ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
          size: 40,
        ),
      ),
    );
  }
}
