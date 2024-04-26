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

    factory Report.fromJson(Map<String, dynamic> json) {
    Report usi = Report(
      id: json['id'],
      problem: json['problem'],
      desc: json['desc'],
      duration: json['duration'],
      startDate: DateTime.parse(json['startDate']),
      rating: json['rating'],
      clientid: json['clientid'],
      usid: json['usid'],
    );
    return usi;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'problem': problem,
      'desc': desc,
      'duration': duration,
      'startDate': startDate.toString(),
      'rating': rating,
      'clientid': clientid,
      'usid': usid
    };
    return data;
  }

}