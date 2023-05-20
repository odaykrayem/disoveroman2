import 'package:disoveroman2/screens/hotels_screen.dart';
import 'package:flutter/material.dart';

import '../models/hotel.dart';

class HotelCategoryItem extends StatelessWidget {
  final String categoryId;
  final String title;
  final String images;
  final List<Hotel> hotels;

  const HotelCategoryItem({
    super.key,
    required this.hotels,
    required this.categoryId,
    required this.title,
    required this.images,
  });

  // for pages Stack
  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(
        builder: (context) => HotelsScreen(
              hotels: hotels,
              categoryId: categoryId,
              title: title,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // here we can go to the next pages
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),

      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: images.contains('google')
                ? Image.network(
                    images,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    images,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
          ),
          //Text style
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white70,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lobster'),
            ),
          )
        ],
      ),
    );
  }
}
