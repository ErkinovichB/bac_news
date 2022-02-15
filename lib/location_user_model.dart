class LocationUserModel {
  int id;
  double latitude;
  double longitude;

  LocationUserModel({
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
