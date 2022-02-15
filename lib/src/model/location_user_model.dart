class LocationUserModel {
  int id;
  double latitude;
  double longitude;
  String currentTime;

  LocationUserModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.currentTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "current_time": currentTime,
    };
  }
}
