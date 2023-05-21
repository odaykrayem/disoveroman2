import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../screens/hotel_details_screen.dart';

class HotelItem extends StatelessWidget {
  final Hotel hotel;
  final String categoryId;

  const HotelItem({
    super.key,
    required this.hotel,
    required this.categoryId,
  });

  void selectHotel(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            HotelDetailsScreen(hotel: hotel, categoryId: categoryId)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectHotel(context),
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
                  child: hotel.images.contains('google')
                      ? Image.network(
                          hotel.images,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          hotel.images,
                          height: 250,
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
                        1
                      ])),
                  child: Text(
                    hotel.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontFamily: 'BebasNeue'),
                    overflow: TextOverflow.fade,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
