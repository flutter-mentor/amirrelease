class LocationModel {
  late double lat;
  late double long;
  LocationModel({
    required this.lat,
    required this.long,
  });
  LocationModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }
  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'long': long,
    };
  }
}
