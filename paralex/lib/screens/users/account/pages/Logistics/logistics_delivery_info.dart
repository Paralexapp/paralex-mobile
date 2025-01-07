import 'dart:developer';
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

  GoogleMapController? _mapController;

  // Markers and Initial Location
  final LatLng _initialLocation = const LatLng(37.7749, -122.4194);

  Marker? _fromMarker;
  Marker? _toMarker;

  Position? _currentPosition;
  LatLng _currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  getLocation() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Geolocator.checkPermission();
      // if (pp.name == LocationPermission.always) {
      _currentPosition =
          await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      _mapController?.animateCamera(CameraUpdate.newLatLng(
        _currentLatLng,
      ));
      setState(() {});
    });
  }

  Future<void> _handleLocationSelection(PlaceModel place, {required bool isFrom}) async {
    try {
      LatLng position = LatLng(double.tryParse(place.latitude) ?? 0.0,
          double.tryParse(place.longitude) ?? 0.0);

      setState(() {
        if (isFrom) {
          _fromMarker = Marker(
            markerId: MarkerId("from"),
            position: position,
            infoWindow: InfoWindow(title: "From Location"),
          );
        } else {
          _toMarker = Marker(
            markerId: MarkerId("to"),
            position: position,
            infoWindow: InfoWindow(title: "To Destination"),
          );
        }
        _mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target:
                  position, //LatLng(place.latitude, place.longitude), // Assuming PlaceModel has these fields
              zoom: 19.0,
            ),
          ),
        );
      });
    } catch (e) {
      print("Error handling location selection: $e");
    }
  }

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
                            hintText: 'From',
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
                            hintText: 'To',
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
                          LogisticsTextfield(
                            controller: _orderDetailsController,
                            showPrefixIcon: true,
                            hintText: 'Order details',
                            icon: Iconsax.d_rotate,
                          ),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          // LogisticsTextfield(
                          //   controller: _fareController,
                          //   showPrefixIcon: true,
                          //   hintText: 'Fare',
                          //   icon: Iconsax.moneys,
                          // ),
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
      onMapCreated: (controller) => _mapController = controller,
      initialCameraPosition: CameraPosition(
        target: _initialLocation,
        zoom: 14.0,
      ),
      markers: {
        if (_fromMarker != null) _fromMarker!,
        if (_toMarker != null) _toMarker!,
      },
    );
  }
}
