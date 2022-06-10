class RequestModel {
  late String uid;
  late bool hasAccept;
  late String name;
  late String lastname;
  late String phone;
  late String eMail;
  RequestModel({
    required this.uid,
    required this.hasAccept,
    required this.lastname,
    required this.name,
    required this.eMail,
    required this.phone,
  });
  RequestModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    hasAccept = json['hasAccept'];
    name = json['name'];
    lastname = json['lastname'];
    phone = json['phone'];
    eMail = json['eMail'];
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'hasAccept': hasAccept,
      'lastname': lastname,
      'name': name,
      'eMail': eMail,
      'phone': phone,
    };
  }
}
