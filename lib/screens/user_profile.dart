import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disoveroman2/screens/welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../common/values/color.dart';
import '../common/values/constant.dart';
import '../utils/global.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // TextEditingController name_Controller = TextEditingController();
  // TextEditingController EmpId_Controller = TextEditingController();
  var db = FirebaseFirestore.instance;
  String userID =
      Global.storageService.getString(AppConstants.STORAGE_USER_UID_KEY);
  String userName = '';
  String userEmail = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'User Profile',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.black45,
                fontSize: 29,
                fontWeight: FontWeight.bold,
                fontFamily: 'AprilFatface'),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userID)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.hasError) return Text('Something went wrong');
              if (true) {
                if (!snapshot.hasData) {
                  return SkeletonListView();
                }
                // debugPrint('${snapshot.data!['name']}');
                try {
                  userName = snapshot.data!['name'];
                  userEmail = snapshot.data!['email'];

                  return Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            buildSelectionTitle(
                                context, 'Name', Icons.assignment_ind_rounded),
                            buildInfoSection(userName),
                            buildSelectionTitle(context, 'Email', Icons.email),
                            buildInfoSection(userEmail),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        // InkWell(
                        //   onTap: () {
                        //     // FirebaseAuth.instance.signOut();
                        //     _signOut();
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(
                        //         vertical: 15, horizontal: 100),
                        //     decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         color: AppColors.primaryElementBg,
                        //         boxShadow: const [
                        //           BoxShadow(
                        //             color: Colors.black26,
                        //             blurRadius: 4,
                        //           )
                        //         ]),
                        //     child: const Text(
                        //       "Sign out",
                        //       style: TextStyle(
                        //         fontStyle: FontStyle.italic,
                        //         color: Colors.white,
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 26,
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  );
                } catch (e) {
                  debugPrint('${e.toString()}');
                }
              }
              return SkeletonListView();
            }));
  }

  Widget buildSelectionTitle(
      BuildContext context, String titleText, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Icon(
            icon,
            size: 35,
            color: AppColors.primaryElementStatus,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            titleText,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Widget buildInfoSection(String info) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(info,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 18)),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      debugPrint('signed out :${FirebaseAuth.instance}');
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Welcome()));
    });
  }
}
