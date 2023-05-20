// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../common/values/constant.dart';
import '../models/hotel.dart';
import '../pages/booking_page.dart';
import '../utils/flutter_toast.dart';
import '../utils/global.dart';

class HotelDetailsScreen extends StatefulWidget {
  final Hotel hotel;
  final String categoryId;

  const HotelDetailsScreen({
    Key? key,
    required this.hotel,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  DateTime selectedDate = DateTime.now();
  var db = FirebaseFirestore.instance;

  Widget buildSelectionTitle(BuildContext context, String titleText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topLeft,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  void _bookHotel(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingPage(),
      ),
    );
  }

  Widget buildListViewContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final hotelId = widget.id;
    // final hotel =
    //     Hotel_data.firstWhere((hotel) => hotel.id == hotelId);
    final hotel = widget.hotel;
    Hotel? realTimeHotel;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(hotel.title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black45,
                overflow: TextOverflow.visible,
                fontSize: 20)),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('hotels')
              .doc(widget.categoryId)
              .collection('hotels_list')
              .doc(hotel.id)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) return Text('Something went wrong');
            if (true) {
              if (!snapshot.hasData) {
                return SkeletonListView();
              }
              // debugPrint('${snapshot.data!['name']}');
              try {
                realTimeHotel = Hotel.fromJson(snapshot.data!.data()!);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: hotel.images.contains('google')
                            ? Image.network(
                                hotel.images,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                hotel.images,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildSelectionTitle(context, 'Location'),
                      buildListViewContainer(
                        ListView.builder(
                            itemCount: realTimeHotel!.location.length,
                            itemBuilder: (ctc, index) => Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      realTimeHotel!.location[index],
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buildSelectionTitle(context, 'Available rooms'),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text('${realTimeHotel!.rooms}'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buildSelectionTitle(context, 'Details'),
                      buildListViewContainer(
                        ListView.builder(
                          itemCount: realTimeHotel!.details.length,
                          itemBuilder: (ctx, index) => Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  child: Text('${index + 1}'),
                                ),
                                title: Text(realTimeHotel!.details[index]),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          debugPrint('selcted Cat${widget.categoryId}');
                          debugPrint('selcted hotel${realTimeHotel!.id}');
                          _selectDateAndBook(context, hotel);

                          // _bookHotel(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryElementBg,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                )
                              ]),
                          child: const Text(
                            "Book ",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              } catch (e) {
                debugPrint('${e.toString()}');
              }
            }
            return SkeletonListView();
          }),
    );
  }

  Future<void> _selectDateAndBook(BuildContext context, Hotel hotel) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2023, 5, 20),
        lastDate: DateTime(2040));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(selectedDate);

      String userID =
          Global.storageService.getString(AppConstants.STORAGE_USER_UID_KEY);
      var document = db
          .collection("users_reservations")
          .doc(userID)
          .collection('reservations')
          .doc();
      document.set({
        'id': document.id,
        'title': hotel.title,
        'type': 'Hotel',
        'date': formattedDate
      });
      FirebaseFirestore.instance
          .collection('hotels')
          .doc(widget.categoryId)
          .collection('hotels_list')
          .doc(hotel.id)
          .update({'rooms': hotel.rooms - 1}).then((value) => toastInfo(
              msg: 'Hotel Booked Successfully',
              textColor: Colors.white,
              backgroundColor: AppColors.primaryElementStatus));

      // setState(() {
      //   debugPrint('${selectedDate}');
      //   selectedDate = picked;
      // });
    }
  }
}
