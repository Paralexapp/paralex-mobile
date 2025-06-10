import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paralex/screens/users/account/pages/Logistics/widgets/logistics_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../reusables/paints.dart';
import '../../../../../routes/navs.dart';
import '../../../../../service_provider/models/driver_model.dart';
import '../controllers/logistics_delivery_info_controller.dart';

class WebViewPaymentScreen extends StatefulWidget {
  final Map<String, dynamic> paymentData;

  const WebViewPaymentScreen({super.key, required this.paymentData});

  @override
  _WebViewPaymentScreenState createState() => _WebViewPaymentScreenState();
}

class _WebViewPaymentScreenState extends State<WebViewPaymentScreen> {
  final LogisticsDeliveryInfoController _controller =
      Get.put(LogisticsDeliveryInfoController());
  late final WebViewController _webViewController;
  String authorizationUrl = '';
  String referenceCode = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    authorizationUrl = widget.paymentData["authorization_url"];
    referenceCode = widget.paymentData["reference"];

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(

        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains(
                'https://paralex-be.onrender.com/verify-transaction')) {
              // Trigger modal only on the verify-transaction page
              var nearbyDriver = await _controller.requestDelivery();
              showNearbyDrivers(context, nearbyDriver);
              return NavigationDecision.prevent; // Stop further navigation
            }
            return NavigationDecision.navigate; // Allow navigation for other URLs
          },
        // NavigationDelegate(
        //   onNavigationRequest: (NavigationRequest request) async {
        //     if (request.url.contains(
        //         'https://paralex-app-fddb148a81ad.herokuapp.com/verify-transaction')) {
        //       // _controller.verifyPayment(referenceCode);
        //       var nearbyDriver = await _controller.requestDelivery();
        //       showNearbyDrivers(context, nearbyDriver);
        //       NavigationDecision.prevent;
        //     }
        //     return NavigationDecision.navigate;
        //   },
          // onUrlChange: (url) {
          //   if (url.url!.contains(
          //       'https://paralex-app-fddb148a81ad.herokuapp.com/verify-transaction')) {
          //     _controller.verifyPayment(referenceCode);
          //   }
          // },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) async {
            // var nearbyDriver = await _controller.requestDelivery();
            // showNearbyDrivers(context, nearbyDriver);
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(authorizationUrl));
  }

  void showNearbyDrivers(BuildContext context, List<DriverModel>? nearbyDriver) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust modal height dynamically
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 5,
                decoration: BoxDecoration(
                  color: PaintColors.paralexLightGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Nearby Drivers',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: PaintColors.paralexpurple,
                ),
              ),
              SizedBox(height: 20),
              (nearbyDriver == null || nearbyDriver.isEmpty)
                  ? Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            color: PaintColors.bgColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 1,
                              color: PaintColors.paralexpurple,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(22.0),
                          child: Text(
                              'No Nearby Driver Available \nYou will get a notification when a driver is available'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LogisticsButton(
                        text: 'OK',
                        // check: _formKey.currentState!.validate(),
                        onTap: () {
                          Get.offAllNamed(Nav.home);
                        },
                      ),
                    ])
                  : Expanded(
                      child: ListView.builder(
                        itemCount: nearbyDriver.length,
                        itemBuilder: (context, index) {
                          final rider = nearbyDriver[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _controller.assignDriver(rider);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: PaintColors.bgColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 1,
                                      color: PaintColors.paralexpurple,
                                    )),
                                child: ListTile(
                                  leading: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 1,
                                          color: PaintColors.fadedPinkBg,
                                        )),
                                    child:
                                        Image(image: NetworkImage(rider.riderPhotoUrl)),
                                  ),
                                  title: Text(rider.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: PaintColors.paralexpurple,
                                      )),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Phone: ${rider.phoneNumber}'),
                                      Text('Distance: ${rider.distance.toStringAsFixed(2)} km'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
      ),
      body: Container(
        child: Stack(
          children: [
            WebViewWidget(controller: _webViewController),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
