import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentViewPage extends StatefulWidget {
  String url;
  PaymentViewPage(this.url);

  @override
  State<PaymentViewPage> createState() => _PaymentViewPageState();
}

class _PaymentViewPageState extends State<PaymentViewPage> {
  late WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: WebViewWidget(controller: controller))
    );
  }
}
