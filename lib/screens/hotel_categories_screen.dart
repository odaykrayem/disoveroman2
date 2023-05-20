import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../data/hotel_categoris_data.dart';
import '../models/category_hotel.dart';
import '../models/hotel.dart';
import '../widgets/hotel_category_item.dart';

class HotelCatogariesScreen extends StatelessWidget {
  HotelCatogariesScreen({Key? key}) : super(key: key);

  var db = FirebaseFirestore.instance;
  bool urlT = false;
  String url = '';
  List<CategoryHotel> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         int catI = 2;
        //         // for (int i = 0; i < categories[catI].hotels.length; i++) {
        //         //   editHotel(catI, i);
        //         // }
        //         // uploadCat(catI);
        //         // editHotels();
        //         // uploadHotels(0);
        //       },
        //       icon: const Icon(Icons.add))
        // ],
        title: Text(
          'Search For Hotels ',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.black45,
              fontSize: 29,
              fontWeight: FontWeight.bold,
              fontFamily: 'AprilFatface'),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body:
          // Text('Something went wrong')
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('hotels')
                  // .where('docId', whereIn: listOfDocIds)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasError)
                  return const Text('Something went wrong');
                if (true) {
                  if (!snapshot.hasData) {
                    return SkeletonListView();
                  }
                  debugPrint('${snapshot.data!.docs}');
                  try {
                    categories = snapshot.data!.docs.map((document) {
                      debugPrint('docid:: ${document.id}');
                      debugPrint('docid:: ${document.data}');
                      // debugPrint('rooms ${document.data()[0]['rooms']}');
                      return CategoryHotel.fromJson(
                          document.data(), document.id);
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
                          return HotelCategoryItem(
                            title: categories[i].title,
                            images: categories[i].images,
                            categoryId: categories[i].id,
                            hotels: categories[i].hotels,
                          );
                          //
                        });
                  } catch (e) {
                    debugPrint('${e.toString()}');
                  }
                }
                return SkeletonListView();
              }),
    );
  }

  Future<String> printUrl(String child) async {
    String url1 = '';
    if (child.contains('google')) {
      debugPrint('end Hotel${child}');

      return child;
    }
    try {
      var ref = FirebaseStorage.instance.ref().child(child);
      url1 = (await ref.getDownloadURL()).toString();
    } catch (e) {
      debugPrint('${e.toString()}');
    }
    debugPrint('end Hotel${url1}');
    urlT = true;
    url = url1;

    setState() {}
    return url1;
  }

  editHotels() async {
    var collection = FirebaseFirestore.instance.collection('hotels');
    var querySnapshots = await collection.get();
    int i = 5;
    for (var doc in querySnapshots.docs) {
      await doc.reference.update({
        'rooms': i,
      });
      i++;
    }
  }

  editHotel(int catIndex, int i) async {
    String imgUrl = await printUrl(categories[catIndex].hotels[i].images);

    Hotel newHotel = Hotel(
      id: categories[catIndex].hotels[i].id,
      title: categories[catIndex].hotels[i].title,
      images: imgUrl,
      details: categories[catIndex].hotels[i].details,
      location: categories[catIndex].hotels[i].location,
      rooms: categories[catIndex].hotels[i].rooms,
    );
    categories[catIndex].hotels[i] = newHotel;
    debugPrint(
        'end Hotel: $catIndex $i ${categories[catIndex].hotels[i].images}');
  }

  uploadCat(int i) async {
    // editHotel(i, 3);
    String image = await printUrl(categories[i].images);
    // debugPrint('cat img: ${image}');

    db.collection("hotels").doc().set({
      'id': categories[i].id,
      'title': categories[i].title,
      'image': image,
      // 'hotels': jsonEncode(categories[i].hotels)
      'hotels': categories[i].hotels.map((p) => p.toJson()).toList()
    });
    // debugPrint('end category: ${i}');
  }

  uploadHotels(int categoryIndex) async {
    debugPrint('cat length${categories.length}');
    // int k = categoryIndex;
    for (int k = 0; k < categories.length; k++) {
      List<Hotel> tempHotels = categories[k].hotels;

      for (int i = 0; i < tempHotels.length; i++) {
        var document = db
            .collection("hotels")
            .doc(categories[k].id)
            .collection('hotels_list')
            .doc();
        int j = i + 2;

        document.set({
          'id': document.id,
          'title': tempHotels[i].title,
          'location': tempHotels[i].location.map((p) => p).toList(),
          'details': tempHotels[i].details.map((p) => p).toList(),
          'rooms': j,
          'images': tempHotels[i].images,
        });
      }
    }

    // debugPrint('end category: ${i}');
  }
}
