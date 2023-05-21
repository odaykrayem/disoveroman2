// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:skeletons/skeletons.dart';
// import '../common/values/color.dart';
// import '../common/values/constant.dart';
// import '../models/trip.dart';
// import '../utils/flutter_toast.dart';
// import '../utils/global.dart';

// class TripDetailsScreen extends StatefulWidget {
//   final Trip trip;
//   final String categoryId;

//   const TripDetailsScreen({
//     Key? key,
//     required this.trip,
//     required this.categoryId,
//   }) : super(key: key);

//   @override
//   State<TripDetailsScreen> createState() => _TripDetailsScreenState();
// }

// class _TripDetailsScreenState extends State<TripDetailsScreen> {
//   Widget buildSelectionTitle(BuildContext context, String titleText) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//       alignment: Alignment.topLeft,
//       child: Text(
//         titleText,
//         style: Theme.of(context).textTheme.headlineSmall,
//       ),
//     );
//   }

//   Widget buildListViewContainer(Widget child) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       height: 200,
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(horizontal: 15),
//       child: child,
//     );
//   }

//   DateTime selectedDate = DateTime.now();
//   var db = FirebaseFirestore.instance;
//   @override
//   Widget build(BuildContext context) {
//     // final tripId = trip.id;
//     final trip = widget.trip;
//     Trip? realTimeTrip;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(trip.title,
//             style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                   color: Colors.black45,
//                   overflow: TextOverflow.visible,
//                 )),
//         backgroundColor: Colors.white,
//       ),
//       body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//           stream: FirebaseFirestore.instance
//               .collection('trips')
//               .doc(widget.categoryId)
//               .collection('trips_list')
//               .doc(trip.id)
//               .snapshots(),
//           builder: (BuildContext context,
//               AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
//             if (snapshot.hasError) return Text('Something went wrong');
//             if (true) {
//               if (!snapshot.hasData) {
//                 return SkeletonListView();
//               }
//               // debugPrint('${snapshot.data!['name']}');
//               try {
//                 realTimeTrip = Trip.fromJson(snapshot.data!.data()!, trip.id);

//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 300,
//                         width: double.infinity,
//                         child: trip.images.contains('google')
//                             ? Image.network(
//                                 realTimeTrip!.images,
//                                 fit: BoxFit.cover,
//                               )
//                             : Image.asset(
//                                 realTimeTrip!.images,
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       buildSelectionTitle(context, 'Activities'),
//                       buildListViewContainer(
//                         ListView.builder(
//                             itemCount: realTimeTrip!.activities.length,
//                             itemBuilder: (ctc, index) => Card(
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       vertical: 5,
//                                       horizontal: 10,
//                                     ),
//                                     child: Text(
//                                       realTimeTrip!.activities[index],
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 )),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       buildSelectionTitle(context, 'Available rooms'),
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         height: 50,
//                         padding: const EdgeInsets.all(10),
//                         margin: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Text('${realTimeTrip!.rooms}'),
//                       ),
//                       const SizedBox(
//                         height: 5,
//                       ),
//                       buildSelectionTitle(context, 'Program'),
//                       buildListViewContainer(
//                         ListView.builder(
//                           itemCount: realTimeTrip!.program.length,
//                           itemBuilder: (ctx, index) => Column(
//                             children: [
//                               ListTile(
//                                 leading: CircleAvatar(
//                                   child: Text('Date${index + 1}'),
//                                 ),
//                                 title: Text(realTimeTrip!.program[index]),
//                               ),
//                               const Divider(),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 50,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           debugPrint('selcted Cat${widget.categoryId}');
//                           // debugPrint('selcted hotel${selectedHotel.id}');
//                           _selectDateAndBook(context, trip);

//                           // _bookHotel(context);
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 15, horizontal: 100),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: AppColors.primaryElementBg,
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.black26,
//                                   blurRadius: 4,
//                                 )
//                               ]),
//                           child: const Text(
//                             "Book ",
//                             style: TextStyle(
//                               fontStyle: FontStyle.italic,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 26,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       )
//                     ],
//                   ),
//                 );
//               } catch (e) {
//                 debugPrint('${e.toString()}');
//               }
//             }
//             return SkeletonListView();
//           }),
//     );
//   }

//   Future<void> _selectDateAndBook(BuildContext context, Trip trip) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: selectedDate,
//         firstDate: DateTime(2023, 5, 20),
//         lastDate: DateTime(2040));
//     if (picked != null && picked != selectedDate) {
//       selectedDate = picked;
//       final DateFormat formatter = DateFormat('yyyy-MM-dd');
//       String formattedDate = formatter.format(selectedDate);

//       String userID =
//           Global.storageService.getString(AppConstants.STORAGE_USER_UID_KEY);
//       var document = db
//           .collection("users_reservations")
//           .doc(userID)
//           .collection('reservations')
//           .doc();
//       document.set({
//         'id': document.id,
//         'title': trip.title,
//         'type': 'Trip',
//         'date': formattedDate
//       });
//       FirebaseFirestore.instance
//           .collection('trips')
//           .doc(widget.categoryId)
//           .collection('trips_list')
//           .doc(trip.id)
//           .update({'rooms': trip.rooms - 1}).then((value) => toastInfo(
//               msg: 'Trip Reserved Successfully',
//               textColor: Colors.white,
//               backgroundColor: AppColors.primaryElementStatus));

//       // setState(() {
//       //   debugPrint('${selectedDate}');
//       //   selectedDate = picked;
//       // });
//     }
//   }
// }
