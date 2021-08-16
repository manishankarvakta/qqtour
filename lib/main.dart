import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qqtour/connectivity_provider.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: HomePage(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qqtour App',
        home: HomePage(),
      ),
    );
  }
}

// loadView() {
//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();
//   print(connectivityResult);
//   if (connectivityResult == ConnectivityResult.mobile) {
//     return WebView(
//       initialUrl: "https://qqtour.ru",
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (WebViewController webViewController) {
//         _controller.complete(webViewController);
//       },
//     );
//   } else if (connectivityResult == ConnectivityResult.wifi) {
//     return WebView(
//       initialUrl: "https://qqtour.ru",
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (WebViewController webViewController) {
//         _controller.complete(webViewController);
//       },
//     );
//   } else {
//     return Center(
//       child: Text('Sorry No Internet Connection'),
//     );
//   }
// }
