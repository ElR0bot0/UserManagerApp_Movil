class Client {
  Client({
    required this.id,
    required this.name,
  });

  String id;
  String name;

    factory Client.fromJson(Map<String, dynamic> json) {
    Client client = Client(
      id: json['id'].toString(),
      name: json['name'],
    );
    return client;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': int.parse(id),
      'name': name,
    };
    return data;
  }
}


