import 'package:flutter/material.dart';

import '../models/location_model.dart';
import '../screens/choose_location.dart';

class LocationPicker {
  Future<LocationModel> navigateAndDisplaySelection(
      BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final LocationModel result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const ChooseLocation()),
    );
    return result;
  }
}
