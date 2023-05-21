import 'package:flutter/material.dart';
import '../../models/trip.dart';
import '../screens/trip_details_screen.dart';

class TripItem extends StatelessWidget {
  final Trip trip;
  final String categoryId;

  const TripItem({
    super.key,
    required this.trip,
    required this.categoryId,
  });

  void selectTrip(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TripDetailsScreen(
              trip: trip,
              categoryId: categoryId,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectTrip(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: trip.images.contains('google')
                      ? Image.network(
                          trip.images,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          trip.images,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Container(
                  height: 250,
                  alignment: Alignment.bottomLeft,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.black.withOpacity(0),
                        Colors.black.withOpacity(0.8),
                      ],
                          stops: const [
                        0.6,
                        1,
                      ])),
                  child: Text(
                    trip.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontFamily: 'BebasNeue'),
                    overflow: TextOverflow.fade,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.today,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        '${trip.duration} Days',
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        trip.season,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.family_restroom,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        trip.tripType,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
