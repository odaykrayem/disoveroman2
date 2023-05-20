import 'dart:convert';

import 'package:disoveroman2/models/trip.dart';
import 'package:flutter/material.dart';

class CategoryTrip {
  final String id;
  final String title;
  final String images;
  final List<Trip> trips;

  const CategoryTrip(
      {required this.id,
      required this.images,
      required this.title,
      required this.trips});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'images': images,
      'trips': jsonEncode(trips),
    };
  }

  factory CategoryTrip.fromJson(Map<String, dynamic> json, String docId) {
    return CategoryTrip(
      // id: json['id'],
      id: docId,
      images: json['image'],
      title: json['title'],
      trips: json['trips'] == null
          ? []
          : (json['trips'] as List<dynamic>).map((e) {
              // debugPrint('${e}');
              return Trip.fromJson(e, '');
            }).toList(),
    );
  }
}
