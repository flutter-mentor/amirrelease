class MedicineModel {
  late String name;
  late String effective;
  late double initPrice;
  late String describtion;
  late String img;
  MedicineModel({
    required this.name,
    required this.effective,
    required this.initPrice,
    required this.describtion,
    required this.img,
  });
  MedicineModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    effective = json['effective'];
    initPrice = json['initPrice'];
    describtion = json['describtion'];
    img = json['img'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'effective': effective,
      'initPrice': initPrice,
      'describtion': describtion,
      'img': img,
    };
  }
}
