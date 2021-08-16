import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider with ChangeNotifier {
  Connectivity _connectivity = new Connectivity();

  late bool _isOnline;
  bool get isOnline => _isOnline;

  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((result) async {
      // ignore: unrelated_type_equality_checks
      if (result == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        _isOnline = true;
        notifyListeners();
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = _connectivity.checkConnectivity();

      // ignore: unrelated_type_equality_checks
      if (status == ConnectivityResult.none) {
        _isOnline = false;
        notifyListeners();
      } else {
        await _updateConnectionStatus().then((bool isConnected) {
          _isOnline = isConnected;
          notifyListeners();
        });
      }
    } on PlatformException catch (e) {
      print('PlatformExcption: ' + e.toString());
    }
  }
}

Future<bool> _updateConnectionStatus() async {
  late bool isConnected;
  try {
    final List<InternetAddress> result =
        await InternetAddress.lookup('qqtour.ru');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isConnected = true;
    }
  } on SocketException catch (_) {
    isConnected = false;
  }

  return isConnected;
}
