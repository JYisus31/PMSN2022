class AccountModel {
  int? id;
  String? name;
  String? lastName1;
  String? lastName2;
  String? phoneNumber;
  String? email;
  String? git;
  String? avatar;

  AccountModel({
    this.id,
    this.name,
    this.lastName1,
    this.lastName2,
    this.phoneNumber,
    this.email,
    this.git,
    this.avatar,
  });

  //Map -> Object
  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'],
      name: map['name'],
      lastName1: map['last_name_1'],
      lastName2: map['last_name_2'],
      phoneNumber: map['phone_number'],
      email: map['email'],
      git: map['git'],
      avatar: map['avatar'],
    );
  }

  //Object -> Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'last_name_1': lastName1,
      'last_name_2': lastName2,
      'phone_number': phoneNumber,
      'email': email,
      'git': git,
      'avatar': avatar,
    };
  }
}
