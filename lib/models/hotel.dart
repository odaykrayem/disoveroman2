class Hotel {
  final String id;
  final String title;
  final String images;
  final List<String> location;
  final List<String> details;
  final int rooms;

  const Hotel({
    required this.id,
    required this.title,
    required this.images,
    required this.location,
    required this.details,
    required this.rooms,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'images': images,
      'details': details,
      'rooms': rooms
    };
  }

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
        id: json['id'],
        images: json['images'],
        title: json['title'],
        location:
            json['location'] == null ? [] : List<String>.from(json['location']),
        details:
            json['details'] == null ? [] : List<String>.from(json['details']),
        rooms: json['rooms'] ?? 0);
  }
  // set images(String img) {
  //   images = img;
  // }
}
