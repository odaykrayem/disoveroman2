import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/values/color.dart';
import '../screens/hotel_categories_screen.dart';
import '../screens/reservations.dart';
import '../screens/trip_categories_screen.dart';
import '../screens/user_profile.dart';

Widget buildPage(int index) {
  List<Widget> _widget = [
    HotelCatogariesScreen(),
    TripCatogariesScreen(),
    UserProfile(),
    Reservations()
  ];

  return _widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: "home",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/home.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/home.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "search",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/search.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/search.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "profile",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset("assets/icons/person2.png"),
      ),
      activeIcon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
          "assets/icons/person2.png",
          color: AppColors.primaryElement,
        ),
      )),
  BottomNavigationBarItem(
      label: "reservations",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: const Icon(Icons.book),
      ),
      activeIcon: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const Icon(
            Icons.book,
            color: AppColors.primaryElement,
          ))),
];
