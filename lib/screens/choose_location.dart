import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:disoveroman2/models/location_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../common/service/location_service.dart';
import '../common/values/color.dart';
import '../utils/showToast.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(24.774265, 46.738586),
    zoom: 13.0,
  );

  late GoogleMapController _googleMapController;
  late BitmapDescriptor captinMarkerIcon;

  Set<Marker> markers = <Marker>{};

  late geo.Position _markerLocation;
  LocationModel? choosedLocation;

  var formKey = GlobalKey<FormState>();

  var locationFieldController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: markers,
              onTap: (pos) async {
                markers.clear();
                _markerLocation = geo.Position(
                    longitude: pos.longitude,
                    latitude: pos.latitude,
                    timestamp: DateTime.now(),
                    accuracy: 0.5,
                    altitude: pos.latitude,
                    heading: 1,
                    speed: 1,
                    speedAccuracy: 1);
                setState(() {
                  _addMarker(
                      id: 'marker', location: _markerLocation, updateCam: true);
                  isLoading = true;
                });
                //google map places
                // List<Placemark> placemarks =
                //     await placemarkFromCoordinates(52.2165157, 6.9437819);
                // debugPrint(placemarks[0].country);
                Map<String, dynamic> result =
                    await LocationService().getLocationNameByCoordinates(pos);
                String locationName = result['freeformAddress'];
                var pattern = RegExp(r'\d');
                String locationNameNoNumbers =
                    locationName.replaceAll(pattern, '');
                choosedLocation = LocationModel(
                    name: locationNameNoNumbers,
                    lat: pos.latitude,
                    lon: pos.longitude);

                locationFieldController.text = locationName;
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading
                ? const CircularProgressIndicator(
                    color: Color(0xff00D27F),
                  )
                : Positioned(top: 15, right: 8, left: 8, child: aboveCard()),
            Positioned(bottom: 12, right: 8, left: 8, child: bottomCard()),
          ],
        ),
      ),
    );
  }

  Future checkPermission() async {
    geo.LocationPermission per = await geo.Geolocator.checkPermission();

    if (per == geo.LocationPermission.denied) {
      per = await geo.Geolocator.requestPermission();
      //if user deny permission after asking for it
      if (per == geo.LocationPermission.denied) {
        showToast(text: 'location permission denied');
      }
    }
  }

  void _addMarker(
      {required String id,
      required geo.Position location,
      required bool updateCam}) {
    setState(() {
      Marker marker = Marker(
        markerId: MarkerId(id),
        position: LatLng(location.latitude, location.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );
      markers.add(marker);
      if (updateCam) {
        _googleMapController.moveCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(location.latitude, location.longitude),
                zoom: 11.0)));
      }
    });
  }

  Widget aboveCard() {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.always,
            controller: locationFieldController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return '';
              }
              return null;
            },
            enabled: false,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.grey,
                height: 1.5),
            textAlignVertical: TextAlignVertical.center,
            cursorColor: AppColors.primaryElement,
            cursorHeight: 25,
            cursorWidth: 1,
            maxLines: 2,
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: const Icon(
                Icons.location_on_outlined,
                color: AppColors.primaryElement,
                size: 30,
              ),
              iconColor: AppColors.primaryElement,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: AppColors.primaryElement,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomCard() {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SizedBox(
          height: 40,
          width: 180,
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.of(context).pop(choosedLocation);
              } else {
                showToast(text: 'please choose location');
              }
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              backgroundColor:
                  MaterialStateProperty.all(AppColors.primaryElement),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            child: const Text('save',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
          ),
        ),
      ),
    );
  }
}
