import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  final double height;
  const DividerWidget({
    Key? key,
    this.height = 1.0,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Divider(
      height: height,
      color: Colors.grey,
      thickness: 1.0,
    );
  }
}
