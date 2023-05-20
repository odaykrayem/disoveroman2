import 'dart:convert';

import 'package:flutter/material.dart';

import 'hotel.dart';

class CategoryHotel {
  final String id;
  final String title;
  final String images;
  final List<Hotel> hotels;

  const CategoryHotel({
    required this.id,
    required this.images,
    required this.title,
    required this.hotels,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'images': images,
      'hotels': jsonEncode(hotels),
    };
  }

  factory CategoryHotel.fromJson(Map<String, dynamic> json, String docId) {
    return CategoryHotel(
      // id: json['id'],
      id: docId,
      images: json['image'],
      title: json['title'],
      hotels: json['hotels'] == null
          ? []
          : (json['hotels'] as List<dynamic>).map((e) {
              // debugPrint('${e}');
              return Hotel.fromJson(e);
            }).toList(),
    );
  }
}
