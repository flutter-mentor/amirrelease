class FarmacyModel {
  late String farmacyName;
  late String farmacyPhone;
  late String farmactLogo;
  FarmacyModel({
    required this.farmactLogo,
    required this.farmacyName,
    required this.farmacyPhone,
  });
  FarmacyModel.fromJson(Map<String, dynamic> json) {
    farmactLogo = json['farmactLogo'];
    farmacyName = json['farmacyName'];
    farmacyPhone = json['farmacyPhone'];
  }
  Map<String, dynamic> toMap() {
    return {
      'farmacyName': farmacyName,
      'farmactLogo': farmactLogo,
      'farmacyPhone': farmacyPhone,
    };
  }
}
