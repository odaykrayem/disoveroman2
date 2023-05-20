import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../screens/trips_screen.dart';

class TripCategoryItem extends StatelessWidget {
  final String categoryId;
  final String categoryTitle;
  final String images;
  final List<Trip> trips;
  const TripCategoryItem(
    this.categoryTitle,
    this.images,
    this.categoryId, {
    super.key,
    required this.trips,
  });

  // for pages Stack
  void selectCategory(BuildContext ctx) {
    debugPrint('${categoryId}');
    debugPrint('${categoryTitle}');
    Navigator.of(ctx).push(MaterialPageRoute(
        builder: (context) => TripsScreen(
              categoryId: categoryId,
              categoryTitle: categoryTitle,
              trips: trips,
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
              categoryTitle,
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
