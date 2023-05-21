import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../common/values/color.dart';
import '../pages/reservation_tabs.dart';
import '../screens/hotel_categories_screen.dart';
import '../screens/reservations.dart';
import '../screens/trip_categories_screen.dart';
import '../screens/uber_screen.dart';
import '../screens/user_profile.dart';

Widget buildPage(int index) {
  List<Widget> _widget = [
    HotelCatogariesScreen(),
    TripCatogariesScreen(),
    UserProfile(),
    ReservationsTabs(),
    UberScreen(),
  ];

  return _widget[index];
}

var bottomTabs = [
  BottomNavigationBarItem(
      label: "home",
      icon: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const Icon(
            Icons.home_filled,
          )
          //  Image.asset("assets/icons/home.png"),
          ),
      activeIcon: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const Icon(
            Icons.home_filled,
            color: AppColors.primaryElement,
          )
          //  Image.asset(
          //   "assets/icons/home.png",
          //   color: AppColors.primaryElement,
          // ),
          )),
  BottomNavigationBarItem(
      label: "search",
      icon: SizedBox(width: 20.w, height: 20.h, child: const Icon(Icons.search)
          //  Image.asset("assets/icons/search.png"),
          ),
      activeIcon: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const Icon(
            Icons.search,
            color: AppColors.primaryElement,
          )

          // Image.asset(
          //   "assets/icons/search.png",
          //   color: AppColors.primaryElement,
          // ),
          )),
  BottomNavigationBarItem(
      label: "profile",
      icon: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const Icon(
            Icons.person,
          )
          //  Image.asset("assets/icons/person2.png"),
          ),
      activeIcon: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const Icon(
            Icons.person,
            color: AppColors.primaryElement,
          )
          // Image.asset(
          //   "assets/icons/person2.png",
          //   color: AppColors.primaryElement,
          // ),
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
  BottomNavigationBarItem(
      label: "uber",
      icon: SizedBox(
        width: 20.w,
        height: 20.h,
        child: const Icon(CupertinoIcons.car),
      ),
      activeIcon: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const Icon(
            CupertinoIcons.car,
            color: AppColors.primaryElement,
          ))),
];
