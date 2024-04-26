class US {
  US({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.reportquantity,
    this.ratings,
    this.avgrating = 0.0,
  });

  String id;
  String name;
  String email;
  String password;
  int reportquantity;
  List<int>? ratings;
  double avgrating;

  factory US.fromJson(Map<String, dynamic> json) {
    US usi = US(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      password: json['password'],
      reportquantity: json['reportquantity'],
      ratings: json['ratings'] != null ? List<int>.from(json['ratings']) : null,
      avgrating: json['avgrating'] != null ? double.tryParse(json['avgrating'].toString()) ?? 0.0 : 0.0,
    );
    return usi;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': int.parse(id),
      'name': name,
      'email': email,
      'password': password,
      'reportquantity': reportquantity,
      'avgrating': avgrating,
    };
    if (ratings != null) {
      data['ratings'] = ratings!.map((e) => e).toList();
    }
    return data;
  }
}
