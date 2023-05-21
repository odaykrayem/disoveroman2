import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../data/hotel_data.dart';
import '../models/hotel.dart';
import '../widgets/hotel_item.dart';

class HotelsScreen extends StatefulWidget {
  final String categoryId;
  final String title;
  final List<Hotel> hotels;

  const HotelsScreen(
      {super.key,
      required this.categoryId,
      required this.title,
      required this.hotels});

  @override
  State<HotelsScreen> createState() => _HotelsScreenState();
}

class _HotelsScreenState extends State<HotelsScreen> {
  //final String categoryId;
  @override
  Widget build(BuildContext context) {
    // final filteredHotels = Hotel_data.where((hotel) {
    //   return hotel.categories.contains(widget.categoryId);
    // }).toList();

    List<Hotel> hotels = [];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: AppColors.primaryElementStatus,
                    overflow: TextOverflow.visible,
                  )),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('hotels')
                .doc(widget.categoryId)
                .collection('hotels_list')
                // .where('docId', whereIn: listOfDocIds)
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
                  hotels = snapshot.data!.docs.map((document) {
                    debugPrint('docid:: ${document.id}');
                    debugPrint('docid:: ${document.data}');
                    // debugPrint('rooms ${document.data()[0]['rooms']}');
                    return Hotel.fromJson(document.data());
                  }).toList();

                  return ListView.builder(
                    itemBuilder: (ctx, index) {
                      return HotelItem(
                        categoryId: widget.categoryId,
                        hotel: hotels[index],
                      );
                    },
                    itemCount: hotels.length,
                  );
                } catch (e) {
                  debugPrint('${e.toString()}');
                }
              }
              return SkeletonListView();
            }));
  }
  // body: ListView.builder(
  //   itemBuilder: (ctx, index) {
  //     return HotelItem(
  //       categoryId: widget.categoryId,
  //       hotel: filteredHotels[index],
  //     );
  //   },
  //   itemCount: filteredHotels.length,
  // ));
}
