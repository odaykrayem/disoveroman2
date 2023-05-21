import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disoveroman2/widgets/trip_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../models/trip.dart';

class TripsScreen extends StatefulWidget {
  final String categoryId;
  final String categoryTitle;
  final List<Trip> trips;
  const TripsScreen(
      {super.key,
      required this.categoryId,
      required this.categoryTitle,
      required this.trips});

  @override
  State<TripsScreen> createState() => _TripHomeItemState();
}

class _TripHomeItemState extends State<TripsScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryId = widget.categoryId;
    final categoryTitle = widget.categoryTitle;

    List<Trip> trips = [];

    return Scaffold(
        // backgroundColor: Colors.red,
        appBar: AppBar(
          centerTitle: true,
          title: Text(categoryTitle,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.primaryElementStatus,
                    overflow: TextOverflow.visible,
                  )),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('trips')
                .doc(categoryId)
                .collection('trips_list')
                // .where('docId', whereIn: listOfDocIds)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasError) return Text('Something went wrong');
              if (true) {
                if (!snapshot.hasData) {
                  return SkeletonListView();
                }
                debugPrint('${snapshot.data!.docs}');
                try {
                  trips = snapshot.data!.docs.map((document) {
                    debugPrint('nnn ${document.data()['image']}');
                    return Trip.fromJson(document.data(), document.id);
                  }).toList();

                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return TripItem(
                        categoryId: categoryId,
                        trip: trips[index],
                      );
                    },
                    itemCount: trips.length,
                  );
                } catch (e) {
                  debugPrint('${e.toString()}');
                }
              }
              return SkeletonListView();
            }));
  }

  // ListView.builder(
  //   itemBuilder: (ctx, index) {
  //     return TripItem(
  //       trip: filteredTrips[index],
  //     );
  //   },
  //   itemCount: filteredTrips.length,
  // ));
}
