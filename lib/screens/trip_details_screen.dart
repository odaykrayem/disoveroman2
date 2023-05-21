// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../common/values/constant.dart';
import '../models/trip.dart';
import '../utils/flutter_toast.dart';
import '../utils/global.dart';
import '../widgets/card_container.dart';

class TripDetailsScreen extends StatefulWidget {
  final Trip trip;
  final String categoryId;

  const TripDetailsScreen({
    Key? key,
    required this.trip,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
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
    if (list.length < 3) height = 110;
    if (list.length < 2) height = 75;
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
          clipBehavior: Clip.none,
          children: list
              .map((e) => Chip(
                    // labelPadding:
                    //     EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    label: e.length > 40
                        ? SizedBox(
                            // height: 100,
                            // width:
                            //     (MediaQuery.of(context).size.width / 4) * 3.5,
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(
                                  e,
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  softWrap: true,
                                )),
                              ],
                            ),
                          )
                        : Text(
                            e,
                          ),
                  ))
              .toList(),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    Trip? realTimeTrip;

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('trips')
              .doc(widget.categoryId)
              .collection('trips_list')
              .doc(trip.id)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasError) return Text('Something went wrong');
            if (true) {
              if (!snapshot.hasData) {
                return SkeletonListView();
              }
              try {
                realTimeTrip = Trip.fromJson(snapshot.data!.data()!, trip.id);
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
                              child: trip.images.contains('google')
                                  ? Image.network(
                                      trip.images,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      trip.images,
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
                                    child: Text(trip.title,
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
                                  debugPrint('selcted trip${realTimeTrip!.id}');
                                  _selectDateAndBook(context, trip);

                                  // _bookTrip(context);
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
                                buildSelectionTitle(context, 'Trip Type'),
                                buildItemsListContainer(
                                    list: [realTimeTrip!.tripType], height: 70),
                              ]),
                              cardContainer([
                                buildSelectionTitle(
                                    context, 'Available places'),
                                buildItemsListContainer(
                                  list: ['${realTimeTrip!.rooms}'],
                                ),
                              ]),
                              cardContainer([
                                buildSelectionTitle(context, 'Duration'),
                                buildItemsListContainer(
                                    list: ['${realTimeTrip!.duration}'],
                                    height: 70),
                              ]),
                              cardContainer([
                                buildSelectionTitle(context, 'Season'),
                                buildItemsListContainer(
                                  list: [realTimeTrip!.season],
                                ),
                              ]),
                              cardContainer([
                                buildSelectionTitle(context, 'Activities'),
                                buildItemsListContainer(
                                    list: realTimeTrip!.activities,
                                    height: 200),
                              ]),
                              cardContainer([
                                buildSelectionTitle(context, 'Program'),
                                buildItemsListContainer(
                                    list: realTimeTrip!.program, height: 120),
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

  Future<void> _selectDateAndBook(BuildContext context, Trip trip) async {
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
        'title': trip.title,
        'type': 'Trip',
        'date': formattedDate
      });
      FirebaseFirestore.instance
          .collection('trips')
          .doc(widget.categoryId)
          .collection('trips_list')
          .doc(trip.id)
          .update({'rooms': trip.rooms - 1}).then((value) => toastInfo(
              msg: 'Trip Booked Successfully',
              textColor: Colors.white,
              backgroundColor: AppColors.primaryElementStatus));

      // setState(() {
      //   debugPrint('${selectedDate}');
      //   selectedDate = picked;
      // });
    }
  }
}
