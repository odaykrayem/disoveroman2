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
import '../widgets/card_container.dart';

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
      // margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.topLeft,
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontSize: 20,
              fontFamily: 'Brand-Bold',
              color: AppColors.primary_bg,
            ),
      ),
    );
  }

  Widget buildItemsListContainer(
      {required List<String> list, double height = 200}) {
    if (list.length > 8) height = 283;
    if (list.length > 10) height = 320;
    if (list.length < 3) height = 100;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Center(
        child: Wrap(
          spacing: 20,
          clipBehavior: Clip.hardEdge,
          children: list
              .map((e) => Chip(
                    label: Text(
                      e,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;
    Hotel? realTimeHotel;

    return Scaffold(
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
              try {
                realTimeHotel = Hotel.fromJson(snapshot.data!.data()!);
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 300,
                      flexibleSpace: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: SizedBox(
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
                          ),
                          Positioned(
                            top: 30,
                            left: 15,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            left: 15,
                            child: SizedBox(
                              height: 100,
                              width:
                                  (MediaQuery.of(context).size.width / 4) * 3.5,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(hotel.title,
                                        maxLines: 2,
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontFamily: 'BebasNeue',
                                              color: Colors.white,
                                              overflow: TextOverflow.visible,
                                              fontSize: 40,
                                            )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  debugPrint('selcted Cat${widget.categoryId}');
                                  debugPrint(
                                      'selcted hotel${realTimeHotel!.id}');
                                  _selectDateAndBook(context, hotel);

                                  // _bookHotel(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.primary_bg,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Book ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(
                                            fontFamily: 'Brand-Bold',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 26,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              cardContainer([
                                buildSelectionTitle(context, 'Location'),
                                buildItemsListContainer(
                                    list: realTimeHotel!.location, height: 70),
                              ]),
                              cardContainer([
                                buildSelectionTitle(context, 'Available rooms'),
                                buildItemsListContainer(
                                    list: ['${realTimeHotel!.rooms}'],
                                    height: 50),
                                const SizedBox(
                                  height: 5,
                                ),
                              ]),
                              cardContainer([
                                buildSelectionTitle(context, 'Details'),
                                buildItemsListContainer(
                                    list: realTimeHotel!.details),
                              ]),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
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
    if (picked != null) {
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
