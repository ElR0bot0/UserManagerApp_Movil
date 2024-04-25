import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/report.dart';

class ReportDetailPageUS extends StatefulWidget {
  const ReportDetailPageUS({Key? key}) : super(key: key);

  @override
  _ReportDetailPageStateUS createState() => _ReportDetailPageStateUS();
}

class _ReportDetailPageStateUS extends State<ReportDetailPageUS> {
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
  controllerProblem.text = report.problem;
  controllerDesc.text = report.desc;
  controllerDuration.text = report.duration;
  controllerRating.text = report.rating.toString();
  controllerStartDate.text = report.startDate.toString();
  controllerClient.text = report.clientid.toString();
  controllerUS.text = report.usid.toString();
}


  @override
  Widget build(BuildContext context) {
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
                      child: buildTextField(controllerUS, 'US ID'),
                    ),
                    Flexible(
                      child: buildTextField(controllerClient, 'Client ID'),
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
                    child: buildTextField(controllerUS, 'Support User ID'),
                  ),
                  Flexible(
                    child: buildTextField(controllerClient, 'Client ID'),
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
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time, // Puedes cambiar este icono a cualquier otro que prefieras
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Awaiting for coordinator to rate this report',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
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