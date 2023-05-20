enum Season {
  Winter,
  Spring,
  Summer,
  Autumn,
}

enum TripType {
  Exploration,
  Recovery,
  Activities,
  Therapy,
}

Map<TripType, String> tripTypesMap = {
  TripType.Exploration: "Exploration",
  TripType.Recovery: "Recovery",
  TripType.Activities: "Activities",
  TripType.Therapy: "Therapy",
};
Map<Season, String> seasonMap = {
  Season.Autumn: "Autumn",
  Season.Spring: "Spring",
  Season.Summer: "Summer",
  Season.Winter: "Winter",
};

class Trip {
  final String id;
  // final List<String> categories;
  final String title;
  final String images;
  final List<String> activities;
  final List<String> program;
  final int duration;
  final String season;
  final String tripType;
  final int rooms;

  const Trip({
    required this.id,
    required this.title,
    required this.images,
    required this.activities,
    required this.duration,
    required this.season,
    required this.tripType,
    required this.program,
    required this.rooms,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'images': images,
      'activities': activities,
      'season': season,
      'tripType': tripType,
      'program': program,
      'rooms': rooms,
    };
  }

  factory Trip.fromJson(Map<String, dynamic> json, String docID) {
    return Trip(
        // id: json['id'],
        id: docID,
        images: json['images'],
        title: json['title'],
        duration: json['duration'] ?? '',
        tripType: json['tripType'] ?? '',
        season: json['season'] ?? '',
        program:
            json['program'] == null ? [] : List<String>.from(json['program']),
        activities: json['activities'] == null
            ? []
            : List<String>.from(json['activities']),
        rooms: json['rooms'] ?? 0);
  }
  // set images(String img) {
  //   images = img;
  // }
}
