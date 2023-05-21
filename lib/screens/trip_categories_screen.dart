import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../data/trip_categories_data.dart';
import '../models/category_trip.dart';
import '../models/trip.dart';
import '../widgets/trip_category_item.dart';

class TripCatogariesScreen extends StatefulWidget {
  const TripCatogariesScreen({Key? key}) : super(key: key);

  @override
  State<TripCatogariesScreen> createState() => _TripCatogariesScreenState();
}

class _TripCatogariesScreenState extends State<TripCatogariesScreen> {
  var db = FirebaseFirestore.instance;
  bool urlT = false;
  String url = '';
  List<CategoryTrip> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         // int catI = 5;
          //         // for (int i = 0; i < categories[catI].trips.length; i++) {
          //         //   editTrip(catI, i);
          //         // }
          //         // uploadCat(catI);
          //         // uploadTrips(0);
          //       },
          //       icon: const Icon(Icons.add))
          // ],
          title: Text(
            'Tourist Guide',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.primaryElementStatus,
                fontSize: 29,
                fontWeight: FontWeight.bold,
                fontFamily: 'Brand-Regular'),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        // body: Text('')
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('trips')
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
                  categories = snapshot.data!.docs.map((document) {
                    debugPrint('nnn ${document.data()['image']}');
                    return CategoryTrip.fromJson(document.data(), document.id);
                  }).toList();

                  return GridView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 7 / 8,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (ctx, i) {
                        return TripCategoryItem(categories[i].title,
                            categories[i].images, categories[i].id,
                            trips: categories[i].trips);
                        //
                      });
                } catch (e) {
                  debugPrint('${e.toString()}');
                }
              }
              return SkeletonListView();
            }));
  }

  Future<String> printUrl(String child) async {
    String url1 = '';
    if (child.contains('google')) {
      debugPrint('end trip${child}');

      return child;
    }
    try {
      var ref = FirebaseStorage.instance.ref().child(child);
      url1 = (await ref.getDownloadURL()).toString();
    } catch (e) {
      debugPrint('${e.toString()}');
    }
    debugPrint('end trip${url1}');
    urlT = true;
    url = url1;

    setState() {}
    return url1;
  }

  editTrip(int catIndex, int i) async {
    String imgUrl = await printUrl(categories[catIndex].trips[i].images);

    Trip newTrip = Trip(
        id: categories[catIndex].trips[i].id,
        title: categories[catIndex].trips[i].title,
        images: imgUrl,
        activities: categories[catIndex].trips[i].activities,
        duration: categories[catIndex].trips[i].duration,
        season: categories[catIndex].trips[i].season,
        tripType: categories[catIndex].trips[i].tripType,
        program: categories[catIndex].trips[i].program,
        rooms: categories[catIndex].trips[i].rooms);
    categories[catIndex].trips[i] = newTrip;
    debugPrint(
        'end trip: $catIndex $i ${categories[catIndex].trips[i].images}');
  }

  uploadCat(int i) async {
    // editTrip(i, 3);
    String image = await printUrl(categories[i].images);
    // debugPrint('cat img: ${image}');

    db.collection("trips").doc().set({
      'id': categories[i].id,
      'title': categories[i].title,
      'image': image,
      // 'trips': jsonEncode(categories[i].trips)
      'trips': categories[i].trips.map((p) => p.toJson()).toList()
    });
    // debugPrint('end category: ${i}');
  }

  uploadTrips(int categoryIndex) async {
    debugPrint('cat length${categories.length}');
    // int k = categoryIndex;
    for (int k = 0; k < categories.length; k++) {
      List<Trip> tempTrips = categories[k].trips;

      for (int i = 0; i < tempTrips.length; i++) {
        var document = db
            .collection("trips")
            .doc(categories[k].id)
            .collection('trips_list')
            .doc();
        int j = i + 3;

        document.set({
          'id': tempTrips[i].id,
          'title': tempTrips[i].title,
          'duration': tempTrips[i].duration,
          'images': tempTrips[i].images,
          'activities': tempTrips[i].activities.map((p) => p).toList(),
          'season': tempTrips[i].season,
          'tripType': tempTrips[i].tripType,
          'program': tempTrips[i].program.map((p) => p).toList(),
          'rooms': j,
        });
      }
    }

    // debugPrint('end category: ${i}');
  }
}
