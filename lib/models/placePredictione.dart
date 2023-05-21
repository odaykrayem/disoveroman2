class PlacePredictions {
  String secondary_text; // Secondary text of the place prediction
  String main_text; // Main text of the place prediction
  String place_id; // Place ID of the prediction

  PlacePredictions({
    required this.main_text,
    required this.place_id,
    required this.secondary_text,
  });

  factory PlacePredictions.fromJson(Map<String, dynamic> json) {
    return PlacePredictions(
      place_id: json["place_id"],
      main_text: json["structured_formatting"]["main_text"],
      secondary_text: json["structured_formatting"]["secondary_text"],
    );
  }
}
