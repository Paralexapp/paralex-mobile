import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/routes/navs.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_button.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_textfield.dart';
import 'package:paralex/service_provider/models/place_model.dart';
import 'package:paralex/widgets/dropdown.dart';

import '../../../../../service_provider/view/widgets/places_text_form_field.dart';
import '../controllers/logistics_delivery_info_controller.dart';

class LogisticsDeliveryInfo extends StatefulWidget {
  const LogisticsDeliveryInfo({super.key});

  @override
  State<LogisticsDeliveryInfo> createState() => _LogisticsDeliveryInfoState();
}

class _LogisticsDeliveryInfoState extends State<LogisticsDeliveryInfo> {
  final LogisticsDeliveryInfoController _controller =
      Get.put(LogisticsDeliveryInfoController());

  TextEditingController fromLocationController = TextEditingController();
  TextEditingController toDestinationController = TextEditingController();
  final _orderDetailsController = TextEditingController();
  final _fareController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showOthers = false;
  Position? devicePosition;
  GoogleMapController? _mapController;

  // Markers and Initial Location
  LatLng _initialLocation = LatLng(0.0, 0.0);
  StreamSubscription<Position>? _locationStream;
  Marker? _fromMarker;
  Marker? _toMarker;
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setInitialLocation();
  }

  Future<void> _setInitialLocation() async {
    try {
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          // Permissions denied
          return;
        }
      }

      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.best,
        ),
      );

      setState(() {
        _initialLocation = LatLng(position.latitude, position.longitude);
      });
      debugPrint(
          "current location: ${_initialLocation.longitude} ---latitude==${_initialLocation.latitude}");
    } catch (e) {
      debugPrint("Error getting current location: $e");
    }
  }

  cancelLocationStream() {
    _locationStream?.cancel();
    _locationStream = null;
  }

  Future<void> _handleLocationSelection(PlaceModel place, {required bool isFrom}) async {
    try {
      LatLng position = LatLng(
        double.tryParse(place.latitude) ?? 0.0,
        double.tryParse(place.longitude) ?? 0.0,
      );

      BitmapDescriptor markerIcon = isFrom
          ? BitmapDescriptor.defaultMarker
          : await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size(40, 40)),
              Platform.isIOS
                  ? 'assets/images/marker.png'
                  : 'assets/images/marker_android.png',
            );

      setState(() {
        if (isFrom) {
          _fromMarker = Marker(
            markerId: MarkerId("from"),
            position: position,
            infoWindow: InfoWindow(title: "From Location"),
            icon: markerIcon,
          );
        } else {
          _toMarker = Marker(
            markerId: MarkerId("to"),
            position: position,
            infoWindow: InfoWindow(title: "To Destination"),
            icon: markerIcon,
          );
        }
      });

      // Add the place to the controller
      _controller.addLocation(place);

      // Adjust camera to show both markers
      _updatePolyline();
    } catch (e) {
      print("Error handling location selection: $e");
    }
  }

  void _updatePolyline() {
    if (_fromMarker != null && _toMarker != null) {
      setState(() {
        _polylines = {
          Polyline(
            polylineId: PolylineId("route"),
            points: [
              _fromMarker!.position,
              _toMarker!.position,
            ],
            color: Colors.blue,
            width: 4, // Thickness of the line
          ),
        };
      });
    }
  }

  // Future<void> _handleLocationSelection(PlaceModel place, {required bool isFrom}) async {
  //   try {
  //     LatLng position = LatLng(double.tryParse(place.latitude) ?? 0.0,
  //         double.tryParse(place.longitude) ?? 0.0);
  //
  //     setState(() async {
  //       if (isFrom) {
  //         _fromMarker = Marker(
  //           markerId: MarkerId("from"),
  //           position: position,
  //           infoWindow: InfoWindow(title: "From Location"),
  //         );
  //       } else {
  //         _toMarker = Marker(
  //             markerId: MarkerId("to"),
  //             position: position,
  //             infoWindow: InfoWindow(title: "To Destination"),
  //             icon: await BitmapDescriptor.fromAssetImage(
  //               ImageConfiguration(size: Size(40, 40)),
  //               Platform.isIOS
  //                   ? 'assets/images/marker.png'
  //                   : 'assets/images/marker_android.png',
  //             ));
  //       }
  //       _mapController?.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target:
  //                 position, //LatLng(place.latitude, place.longitude), // Assuming PlaceModel has these fields
  //             zoom: 11.0,
  //           ),
  //         ),
  //       );
  //       _controller.addLocation(place);
  //     });
  //   } catch (e) {
  //     print("Error handling location selection: $e");
  //   }
  // }

  void submitForm() {
    _controller.fareController.value = _fareController.text;
    _controller.orderDetailsController.value = _orderDetailsController.text;

    Get.toNamed(Nav.logisticsHome);
  }

  @override
  Widget build(BuildContext context) {
    log('height: ${deviceHeight(context)} -- width: ${deviceWidth(context)}');
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: deviceHeight(context),
        width: deviceWidth(context),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 7.0,
                ),
                LogisticsCancelButton(),
                SizedBox(
                  height: deviceHeight(context) * 0.45,
                  width: deviceWidth(context),
                  child: _buildGoogleMap(),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: deviceHeight(context) * 0.55,
                width: deviceWidth(context),
                decoration: BoxDecoration(
                  color: PaintColors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 25, right: 25, bottom: 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: deviceWidth(context) * 0.2,
                            height: 5,
                            decoration: BoxDecoration(
                              color: PaintColors.paralexLightGrey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Iconsax.lamp_charge,
                                color: PaintColors.paralexpurple,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Courier delivery',
                                style: FontStyles.bodyText1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          PlacesTextField(
                            controller: fromLocationController,
                            showPrefixIcon: true,
                            hintText: 'From - Enter a Popular area(e.g Ikeja)',
                            icon: Iconsax.location,
                            onSelected: (place) {
                              setState(() {
                                fromLocationController.text = place.displayName;
                              });
                              _controller.senderLatitude.value =
                                  double.parse(place.latitude);
                              _controller.senderLongitude.value =
                                  double.parse(place.longitude);
                              print('${place.latitude}===${place.latitude}');
                              print(
                                  '_controller.senderLongitude.value= ===${_controller.senderLongitude.value}');
                              _handleLocationSelection(place, isFrom: true);
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          PlacesTextField(
                            controller: toDestinationController,
                            showPrefixIcon: true,
                            hintText: 'To - Enter a Popular area(e.g Iyana-ipaja)',
                            icon: Iconsax.gps,
                            onSelected: (place) async {
                              _handleLocationSelection(place, isFrom: false);
                              _controller.recipientLatitude.value =
                                  double.parse(place.latitude);
                              _controller.recipientLongitude.value =
                                  double.parse(place.longitude);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomDropdown(
                              items: ['Parcel', 'Document', 'Others'],
                              hint: 'Order details',
                              icon: Iconsax.d_rotate,
                              onChanged: (val) {
                                if (val?.toLowerCase() == 'others') {
                                  setState(() {
                                    showOthers = true;
                                    _orderDetailsController.clear();
                                  });
                                } else {
                                  setState(() {
                                    showOthers = false;
                                  });
                                  _orderDetailsController.text = val!;
                                }
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: showOthers,
                            child: LogisticsTextfield(
                              controller: _orderDetailsController,
                              showPrefixIcon: true,
                              hintText: 'Order details',
                              icon: Iconsax.moneys,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          LogisticsButton(
                            text: 'CONTINUE',
                            check: false,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) return;
                              submitForm();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildGoogleMap() {
    return GoogleMap(
      onMapCreated: (map) async {
        _mapController = map;
        await _setInitialLocation();

        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_initialLocation, 16),
        );

        try {
          String mapStyle = await DefaultAssetBundle.of(context)
              .loadString('assets/json/map_style.json');
          _mapController?.setMapStyle(mapStyle);
        } catch (e) {
          debugPrint("Error setting map style: $e");
        }
      },
      initialCameraPosition: CameraPosition(
        target: _initialLocation,
        zoom: 11.0,
      ),
      markers: {
        if (_fromMarker != null) _fromMarker!,
        if (_toMarker != null)
          _toMarker!
        else
          Marker(
            markerId: MarkerId("to"),
            position: _initialLocation,
            infoWindow: InfoWindow(title: "Current position"),
          )
      },
      polylines: _polylines,
    );
  }


// Widget _buildGoogleMap() {
  //   _mapController?.animateCamera(
  //     CameraUpdate.newLatLngZoom(_initialLocation, 16),
  //   );
  //   return GoogleMap(
  //     onMapCreated: (map) async {
  //       _setInitialLocation();
  //       _mapController = map;
  //       try {
  //         String mapStyle = await DefaultAssetBundle.of(context)
  //             .loadString('assets/json/map_style.json');
  //         _mapController?.setMapStyle(mapStyle);
  //       } catch (_) {}
  //     },
  //     initialCameraPosition: CameraPosition(
  //       target: _initialLocation,
  //       zoom: 11.0,
  //     ),
  //     markers: {
  //       if (_fromMarker != null) _fromMarker!,
  //       (_toMarker != null)
  //           ? _toMarker!
  //           : Marker(
  //               markerId: MarkerId("to"),
  //               position: _initialLocation,
  //               infoWindow: InfoWindow(title: "Current position"),
  //             )
  //     },
  //     polylines: _polylines,
  //   );
  // }
}
