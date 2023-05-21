import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../common/values/color.dart';
import '../common/values/constant.dart';
import '../models/location_model.dart';
import '../utils/flutter_toast.dart';
import '../utils/global.dart';
import '../utils/location_picker.dart';
import '../widgets/divider.dart';

class UberScreen extends StatefulWidget {
  static const String idScreen = "uberScreen";

  @override
  State<UberScreen> createState() => _UberScreenState();
}

class _UberScreenState extends State<UberScreen> {
  late GoogleMapController newGoogleMapController;
  LocationModel? fromLocation, dropOffLocation;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController fromLocationController = TextEditingController();
  TextEditingController dropOffLocationController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  late Position currentPosition;
  var grolocator = Geolocator();
  double bottomPaddingOfMap = 0;

  String? selectedTime, selectedDate;

  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Book Taxi",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.primaryElementStatus,
              fontSize: 29,
              fontWeight: FontWeight.bold,
              fontFamily: 'Brand-Regular'),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 470.0,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(18)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 16.0,
                  spreadRadius: 0.3,
                  offset: Offset(0.1, 0.1),
                )
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4.0),
                  const Text(
                    "Hi There,",
                    style: TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(height: 4.0),
                  const Text(
                    "From Where?",
                    style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextField(
                    fromLocationController,
                    hint: 'Choose Location',
                    onTap: () async {
                      fromLocation = await LocationPicker()
                          .navigateAndDisplaySelection(context);
                      fromLocationController.text = fromLocation!.name;
                      debugPrint('${fromLocation!.name}');
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    "To Where?",
                    style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTextField(
                    dropOffLocationController,
                    hint: 'Choose Location',
                    onTap: () async {
                      dropOffLocation = await LocationPicker()
                          .navigateAndDisplaySelection(context);
                      dropOffLocationController.text = dropOffLocation!.name;
                      debugPrint('${dropOffLocation!.name}');
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  buildTimeDateTextField(dateController,
                      title: 'Choose Date',
                      icon: Icons.date_range,
                      hint: 'Date', onTap: () async {
                    selectedDate = await selectDate();
                    debugPrint('selcted date : ${selectedDate}');
                    dateController.text = selectedDate ?? '';
                    debugPrint('selcted date : ${dateController.text}');
                  }),
                  const DividerWidget(),
                  const SizedBox(
                    height: 3.0,
                  ),
                  buildTimeDateTextField(timeController,
                      title: 'Choose Time',
                      icon: Icons.schedule,
                      hint: 'Choose Time', onTap: () async {
                    selectedTime = await selectTime(context);
                    debugPrint('selcted time : ${selectedTime}');
                    timeController.text = selectedTime ?? '';
                    debugPrint('selcted date : ${timeController.text}');
                  }),
                  Center(child: saveButton(() {
                    debugPrint('${selectedDate}');
                    debugPrint('${selectedTime}');
                    if (fromLocation == null) {
                      toastInfo(
                        msg: 'Please choose From Location',
                        backgroundColor: Colors.redAccent,
                      );
                    } else if (dropOffLocation == null) {
                      toastInfo(
                        msg: 'Please choose Drop Off Location',
                        backgroundColor: Colors.redAccent,
                      );
                    } else if (selectedDate == null) {
                      toastInfo(
                        msg: 'Please choose Date',
                        backgroundColor: Colors.redAccent,
                      );
                    } else if (selectedTime == null) {
                      toastInfo(
                        msg: 'Please choose Time',
                        backgroundColor: Colors.redAccent,
                      );
                    } else {
                      String userID = Global.storageService
                          .getString(AppConstants.STORAGE_USER_UID_KEY);
                      var document = db
                          .collection("taxi_booking")
                          .doc(userID)
                          .collection('reservations')
                          .doc();
                      document.set({
                        'id': document.id,
                        'fromLocation': fromLocation!.name,
                        'dropOffLocation': dropOffLocation!.name,
                        'date': selectedDate,
                        'time': selectedTime,
                      }).then((value) => toastInfo(
                          msg: 'Taxi Booked Successfully',
                          textColor: Colors.white,
                          backgroundColor: AppColors.primaryElementStatus));
                    }
                  }))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller, {
    required String hint,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 6.0,
              spreadRadius: 0.5,
              offset: Offset(0.7, 0.7),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.search,
              color: Colors.green,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Container(
                // color: Colors.red,
                child: TextField(
                  controller: controller,
                  enabled: false,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(0),
                    hintText: hint,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.transparent,
                    )),
                    disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.transparent,
                    )),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.transparent,
                    )),
                    hintStyle: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 16,
                    ),
                  ),
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    // fontFamily: "Lobster",
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeDateTextField(
    TextEditingController controller, {
    required String title,
    required IconData icon,
    required String hint,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 75,
        padding: const EdgeInsets.all(12.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 25,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 4),
                        hintText: hint,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.transparent,
                        )),
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        // fontFamily: "Lobster",
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget saveButton(VoidCallback onPressed) {
    return SizedBox(
      height: 40,
      width: 180,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor:
              MaterialStateProperty.all(AppColors.primaryElementStatus),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        child: const Text('Submit',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16)),
      ),
    );
  }

  Future<String> selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023, 5, 21),
        lastDate: DateTime(2040));
    if (picked != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(picked);
      return formattedDate;
    }
    return '';
  }

  Future<String> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final DateFormat formatter = DateFormat('HH:mm');
      // String formattedDate = formatter.format(picked);
      return picked.format(context);
    }
    return '';
  }
}
