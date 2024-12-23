import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains(
                'https://paralex-app-fddb148a81ad.herokuapp.com/verify-transaction')) {
              _controller.verifyPayment(referenceCode);
              NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
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
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(authorizationUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
