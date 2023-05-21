import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disoveroman2/models/reservation.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import '../common/values/color.dart';
import '../common/values/constant.dart';
import '../screens/reservations.dart';
import '../screens/taxi_reservations.dart';
import '../utils/global.dart';
import '../widgets/card_container.dart';

class ReservationsTabs extends StatefulWidget {
  const ReservationsTabs({
    super.key,
  });

  @override
  State<ReservationsTabs> createState() => _ReservationsTabsState();
}

class _ReservationsTabsState extends State<ReservationsTabs>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Container(
              height: 50.0,
              child: TabBar(
                controller: tabController,
                indicatorColor: AppColors.primaryElement,
                unselectedLabelColor: Colors.grey,
                labelColor: AppColors.primaryElement,
                labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Brand-Regular'),
                tabs: [
                  Tab(
                    text: "Hotel/Trip",
                  ),
                  Tab(
                    text: "Taxi",
                  ),
                ],
              ),
            ),
          ),
          // appBar: AppBar(
          //   centerTitle: true,
          //   title: Text(
          //     'User Reservations',
          //     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          //         color: Colors.black45,
          //         fontSize: 29,
          //         fontWeight: FontWeight.bold,
          //         fontFamily: 'Brand-Regular'),
          //   ),
          // ),
          body: TabBarView(
            controller: tabController,
            children: [Reservations(), TaxiReservationsTab()],
          )),
    );
  }
}
