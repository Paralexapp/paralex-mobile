import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:paralex/reusables/fonts.dart';
import 'package:paralex/reusables/paints.dart';
import 'package:paralex/reusables/ui_helpers.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_button.dart';
import 'package:paralex/screens/users/account/pages/controllers/logistics_delivery_info_controller.dart';

import 'widgets/logistics_textfield.dart';

class LogisticsFindDelivery extends StatefulWidget {
  final String? fromLocation;
  final String? toDestination;
  final String? orderDetails;
  final int? fare;
  final int? distance;
  const LogisticsFindDelivery(
      {super.key,
      this.fromLocation,
      this.toDestination,
      this.orderDetails,
      this.fare,
      this.distance});

  @override
  State<LogisticsFindDelivery> createState() => _LogisticsFindDeliveryState();
}

class _LogisticsFindDeliveryState extends State<LogisticsFindDelivery> {
  final LogisticsDeliveryInfoController _controller =
      Get.put(LogisticsDeliveryInfoController());

  final _formKey = GlobalKey<FormState>();

  final fromLocationController = TextEditingController();

  final toDestinationController = TextEditingController();

  final orderDetailsController = TextEditingController();

  final fareController = TextEditingController();
  final distanceController = TextEditingController();

  late GoogleMapController? _mapController;
  LatLng _initialLocation = LatLng(6.5244, 3.3792); // Default to Lagos
  Marker? _fromMarker;
  Marker? _toMarker;
  Set<Polyline> _polylines = {};

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


  @override
  void initState() {
    super.initState();
    fromLocationController.text = widget.fromLocation ?? '';

    toDestinationController.text = widget.toDestination ?? '';
    orderDetailsController.text = widget.orderDetails ?? '';
    // distanceController.text = widget.distance?.toString() ?? '';
    // Add "km" after the distance
    distanceController.text = widget.distance != null
        ? '${widget.distance} km'
        : '';
    fareController.text = NumberFormat.currency(
      decimalDigits: 2,
      symbol: "₦",
    ).format(widget.fare ?? 0);
  }

  @override
  Widget build(BuildContext context) {
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

                // SizedBox(
                //   height: deviceHeight(context) * 0.45,
                //   width: deviceWidth(context),
                //   child: Image.asset(
                //     'assets/images/map.jpg',
                //     fit: BoxFit.cover,
                //   ),
                // ),
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
                                'Confirm delivery',
                                style: FontStyles.bodyText1,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          LogisticsTextfield(
                            controller: fromLocationController,
                            showPrefixIcon: true,
                            readOnly: true,
                            borderColor: PaintColors.textFieldBorderColor,
                            hintText: 'From',
                            icon: Iconsax.location,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          LogisticsTextfield(
                            controller: toDestinationController,
                            showPrefixIcon: true,
                            readOnly: true,
                            borderColor: PaintColors.textFieldBorderColor,
                            hintText: 'To',
                            icon: Iconsax.gps,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          LogisticsTextfield(
                            controller: orderDetailsController,
                            showPrefixIcon: true,
                            readOnly: true,
                            borderColor: PaintColors.textFieldBorderColor,
                            hintText: 'Order details',
                            icon: Iconsax.d_rotate,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          LogisticsTextfield(
                            controller: fareController,
                            borderColor: PaintColors.textFieldBorderColor,
                            showPrefixIcon: true,
                            readOnly: true,
                            hintText: 'Fare',
                            icon: Iconsax.moneys,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          LogisticsTextfield(
                            controller: distanceController,
                            borderColor: PaintColors.textFieldBorderColor,
                            showPrefixIcon: true,
                            readOnly: true,
                            hintText: 'Distance',
                            icon: Icons.social_distance,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          LogisticsButton(
                            text: 'PROCEED TO PAYMENT',
                            // check: _formKey.currentState!.validate(),
                            onTap: () {
                              // Multiply the fare by 100 before passing it to the payment gateway
                              int amountInKobo = (widget.fare ?? 0) * 100;

                              // Pass the amountInKobo (in kobo) to the initializePayment function
                              _controller.initializePayment(amountInKobo.toString());
                              // _controller.initializePayment(widget.fare?.toString() ?? '0');
                              // Get.toNamed(Nav.logisticsPaymentMethod);
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
  Future<void> _setInitialLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        setState(() {
          _initialLocation = LatLng(position.latitude, position.longitude);
          _fromMarker = Marker(
            markerId: MarkerId("from"),
            position: _initialLocation,
            infoWindow: InfoWindow(title: "Current Location"),
          );
        });
      }
    } catch (e) {
      debugPrint("Failed to get location: $e");
    }
  }

}
