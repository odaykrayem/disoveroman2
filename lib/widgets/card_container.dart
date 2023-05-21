import 'package:flutter/material.dart';

Widget cardContainer(List<Widget> children,
    {Color backgroundColor = Colors.white, double? padding}) {
  return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        //set border radius more than 50% of height and width to make circle
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: padding ?? 8.0),
        child: Column(
          children: children,
        ),
      ));
}

Widget cardContainerRow(List<Widget> children) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        //set border radius more than 50% of height and width to make circle
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: children,
        ),
      ));
}
