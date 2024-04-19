import 'package:f_testing_template/ui/controllers/us_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/report.dart';
import '../../../domain/entities/us.dart';
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
    controllerRating.text = report.rating.toString();
    controllerStartDate.text = report.startDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    ReportController reportController = Get.find();
    USController usController = Get.find();

    if (report.rating > 0) {
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
                Text(
                  'Rating',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ), Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  int.parse(controllerRating.text),
                  (index) => Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 32,
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      );
    }

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
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  int rating = int.tryParse(controllerRating.text) ?? 0;
                  if (rating == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('You must select a rating')),
                    );
                  } else {
                     Report newreport = report;
                     newreport.rating = rating;
                     reportController.rateReport(newreport);
                     US newus = report.us;
                     if(newus.ratings == null) {
                        newus.ratings = [rating];
                     } else {
                        newus.ratings?.add(rating);
                     }
                     
                     int suma = 0;
                    if (newus.ratings != null) {
                      for (int ratingg in newus.ratings!) {
                        suma += ratingg;
                      }
                    }
                     double avg = suma / newus.ratings!.length;
                     newus.avgrating = avg;
                     usController.updateUS(newus);
                     Get.back();
                    }
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
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              controller.text = (index + 1).toString();
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: index < rating ? Colors.yellow : Colors.grey,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
