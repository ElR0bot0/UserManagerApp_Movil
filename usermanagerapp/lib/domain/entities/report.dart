import 'package:f_testing_template/domain/entities/client.dart';
import 'package:f_testing_template/domain/entities/us.dart';

class Report {
  Report({
    this.id,
    required this.client,
    required this.us,
    required this.problem,
    required this.desc,
    required this.duration,
    this.rating,
    required this.startDate
  });

  int? id;
  Client client;
  US us;
  String problem;
  String desc;
  int? rating;
  String duration;
  DateTime startDate;
}