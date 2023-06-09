import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disoveroman2/models/taxi_book.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../common/values/constant.dart';
import '../utils/global.dart';
import '../widgets/card_container.dart';
import '../widgets/divider.dart';

class TaxiReservationsTab extends StatefulWidget {
  const TaxiReservationsTab({
    super.key,
  });

  @override
  State<TaxiReservationsTab> createState() => _TaxiReservationsTabState();
}

class _TaxiReservationsTabState extends State<TaxiReservationsTab> {
  @override
  Widget build(BuildContext context) {
    List<TaxiBook> taxiReservations = [];
    String userID =
        Global.storageService.getString(AppConstants.STORAGE_USER_UID_KEY);
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: AppColors.primaryElementStatus,
        //   title: Text(
        //     'Taxi Reservations',
        //     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
        //         color: Colors.white,
        //         fontSize: 29,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'Brand-Regular'),
        //   ),
        // ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('taxi_booking')
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
                  taxiReservations = snapshot.data!.docs.map((document) {
                    debugPrint('docid:: ${document.id}');
                    debugPrint('docid:: ${document.data}');
                    // debugPrint('rooms ${document.data()[0]['rooms']}');
                    return TaxiBook.fromJson(document.data());
                  }).toList();

                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return cardContainer([
                        Container(
                          height: 250,
                          // padding: const EdgeInsets.all(3),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 0),
                          child: Column(
                            children: [
                              buildItemLine(
                                  'From',
                                  taxiReservations[index].fromLocation,
                                  Icons.location_on_outlined),
                              const DividerWidget(height: 0),
                              buildItemLine(
                                  'To',
                                  taxiReservations[index].dropOffLocation,
                                  Icons.location_pin),
                              const DividerWidget(height: 0),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: buildItemLine(
                                        'Date',
                                        taxiReservations[index].date,
                                        Icons.date_range),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: buildItemLine(
                                        'Time',
                                        taxiReservations[index].time,
                                        Icons.schedule),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                          backgroundColor: AppColors.primaryElementStatus,
                          padding: 0);
                    },
                    itemCount: taxiReservations.length,
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
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(30)),
        child: Icon(
          icon,
          size: 25,
          // color: AppColors.primaryElement,
          color: Colors.white,
        ),
      ),
      // isThreeLine: true,
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.white),
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
                style: const TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
