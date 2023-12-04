class UpdateUser {
  String? firstName;
  String? lastName;
  String? email;
  String? updatedAt;

  UpdateUser({this.firstName, this.lastName, this.email, this.updatedAt});

  UpdateUser.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
