import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qqtour/connectivity_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pageUI(),
      ),
    );
  }

  Widget pageUI() {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      final Completer<WebViewController> _controller =
          Completer<WebViewController>();
      // ignore: unrelated_type_equality_checks
      if (model.isOnline != null) {
        if (model.isOnline) {
          return WebView(
            initialUrl: "https://qqtour.ru",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off,
                  color: Colors.orange,
                  size: 50.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Sorry No Internet Connection',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Please Connect to Internet and Try Again'),
                SizedBox(
                  height: 10,
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
