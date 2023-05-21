class TaxiBook {
  final String id;
  final String fromLocation;
  final String dropOffLocation;
  final String date;
  final String time;

  const TaxiBook({
    required this.id,
    required this.fromLocation,
    required this.dropOffLocation,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromLocation': fromLocation,
      'dropOffLocation': dropOffLocation,
      'date': date,
      'time': time,
    };
  }

  factory TaxiBook.fromJson(Map<String, dynamic> json) {
    return TaxiBook(
      id: json['id'],
      dropOffLocation: json['dropOffLocation'],
      fromLocation: json['fromLocation'],
      date: json['date'],
      time: json['time'],
    );
  }
}
