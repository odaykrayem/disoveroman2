import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disoveroman2/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../common/values/constant.dart';
import '../models/hotel.dart';
import '../utils/global.dart';
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
  //final String categoryId;
  @override
  Widget build(BuildContext context) {
    // final filteredHotels = Hotel_data.where((hotel) {
    //   return hotel.categories.contains(widget.categoryId);
    // }).toList();

    List<Reservation> reservations = [];
    String userID =
        Global.storageService.getString(AppConstants.STORAGE_USER_UID_KEY);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Reservations',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Colors.black45,
                    overflow: TextOverflow.visible,
                  )),
        ),
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
                    // debugPrint('rooms ${document.data()[0]['rooms']}');
                    return Reservation.fromJson(document.data());
                  }).toList();

                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 100,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: const Icon(
                            Icons.book,
                            size: 40,
                            color: AppColors.primaryElement,
                          ),
                          isThreeLine: true,
                          title: Text(reservations[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontSize: 20,
                                    color: Colors.black45,
                                    overflow: TextOverflow.visible,
                                  )),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(reservations[index].date,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.black45,
                                          overflow: TextOverflow.visible,
                                        )),
                                Text(reservations[index].type,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                          fontSize: 20,
                                          color: Colors.black45,
                                          overflow: TextOverflow.visible,
                                        )),
                              ],
                            ),
                          ),
                        ),
                      );

                      // Text(reservations[index].title);

                      // HotelItem(
                      //   categoryId: widget.categoryId,
                      //   hotel: hotels[index],
                      // );
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
}
