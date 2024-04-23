import 'package:f_testing_template/domain/entities/client.dart';
import 'package:f_testing_template/domain/entities/us.dart';

class Report {
  Report({
    this.id,
    required this.clientid,
    required this.usid,
    required this.problem,
    required this.desc,
    required this.duration,
    required this.rating,
    required this.startDate
  });

  int? id;
  int clientid;
  int usid;
  String problem;
  String desc;
  int rating;
  String duration;
  DateTime startDate;
}