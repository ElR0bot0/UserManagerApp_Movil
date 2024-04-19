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
}