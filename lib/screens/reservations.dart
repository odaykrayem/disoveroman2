import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disoveroman2/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../common/values/constant.dart';
import '../models/hotel.dart';
import '../utils/global.dart';
import '../widgets/card_container.dart';
import '../widgets/divider.dart';
import '../widgets/hotel_item.dart';

class Reservations extends StatefulWidget {
  // final String categoryId;
  // final String title;
  // final List<Hotel> hotels;

  const Reservations({
    super.key,
    // required this.categoryId,
    // required this.title,
    // required this.hotels
  });

  @override
  State<Reservations> createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  @override
  Widget build(BuildContext context) {
    List<Reservation> reservations = [];
    String userID =
        Global.storageService.getString(AppConstants.STORAGE_USER_UID_KEY);
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(
        //     'Reservations',
        //     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        //         color: AppColors.primaryElementStatus,
        //         fontSize: 29,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'Brand-Regular'),
        //   ),
        // ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users_reservations')
                .doc(userID)
                .collection('reservations')
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) return const Text('Something went wrong');
              if (true) {
                if (!snapshot.hasData) {
                  return SkeletonListView();
                }
                debugPrint('${snapshot.data!.docs}');
                try {
                  reservations = snapshot.data!.docs.map((document) {
                    debugPrint('docid:: ${document.id}');
                    debugPrint('docid:: ${document.data}');
                    return Reservation.fromJson(document.data());
                  }).toList();

                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return cardContainer([
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 270,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              buildItemLine(
                                'Location',
                                reservations[index].title,
                                Icons.location_searching_outlined,
                              ),
                              const DividerWidget(height: 0),
                              buildItemLine(
                                'Reservation Type',
                                reservations[index].type,
                                Icons.local_activity_sharp,
                              ),
                              const DividerWidget(height: 0),
                              buildItemLine(
                                'Reservation Date',
                                reservations[index].date,
                                Icons.date_range_outlined,
                              ),
                            ],
                          ),
                        ),
                      ],
                          backgroundColor: AppColors.primaryElementStatus,
                          padding: 0);
                    },
                    itemCount: reservations.length,
                  );
                } catch (e) {
                  debugPrint('${e.toString()}');
                }
              }
              return SkeletonListView();
            }));
  }

  Widget buildItemLine(String title, String subtitle, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryElement),
            borderRadius: BorderRadius.circular(30)),
        child: Icon(
          icon,
          size: 25,
          color: AppColors.primaryElement,
        ),
      ),
      // isThreeLine: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                subtitle,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
