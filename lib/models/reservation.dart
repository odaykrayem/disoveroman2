class Reservation {
  final String id;
  final String title;
  final String type;
  final String date;

  const Reservation({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'date': date,
    };
  }

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      date: json['date'],
    );
  }
}
