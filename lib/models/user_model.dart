class UserModel {
  late String name;
  late String lastname;
  late String phone;
  late String eMail;
  late String uId;
  late bool isPatient;
  late String profilePic;
  UserModel({
    required this.name,
    required this.phone,
    required this.eMail,
    required this.uId,
    required this.lastname,
    required this.isPatient,
    required this.profilePic,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    eMail = json['eMail'];
    uId = json['uId'];
    lastname = json['lastname'];
    isPatient = json['isPatient'];
    profilePic = json['profilePic'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'eMail': eMail,
      'uId': uId,
      'lastname': lastname,
      'isPatient': isPatient,
      'profilePic': profilePic,
    };
  }
}
