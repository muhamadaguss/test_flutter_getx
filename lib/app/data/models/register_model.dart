class Register {
  int? id;
  String? token;

  Register({this.id, this.token});

  Register.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['token'] = token;
    return data;
  }
}
