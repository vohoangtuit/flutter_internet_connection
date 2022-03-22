import 'dart:io'; //InternetAddress utility
import 'dart:async'; //For StreamController/Stream

import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';

import '../general/main_bloc.dart';

class Connection extends MainBloc{
  //static final Connection _singleton = Connection._internal();

 // Connection._internal();

  Connection();

 // static Connection getInstance() => _singleton;

   StreamController? connectionChangeController;
  Stream get connectionChange => connectionChangeController!.stream;
  bool hasConnection = false;

  Connectivity? _connectivity;

  void initialize() {
     connectionChangeController =  StreamController.broadcast();
    _connectivity = Connectivity();
    _connectivity!
        .checkConnectivity()
        .then((value) => {
          _updateConnectionStatus(value)}
    );
    _connectivity!.onConnectivityChanged.listen((value) {
      if(_isDisposed) {
        return;
      }
      _updateConnectionStatus(value);
    });
  }
  bool _isDisposed = false;

  void dispose() {
    //super.dispose();
    if(connectionChangeController!=null){
      connectionChangeController!.close();
      _isDisposed =true;
    }
  }

  void _connectionChange(ConnectivityResult result) {
    _updateConnectionStatus(result);
    // _checkConnection();
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print('result ${result.toString()}');
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        //  hasConnection =true;
        //connectionChangeController!.add(true);
      connectionChangeController!.sink.add(true);
    break;
      case ConnectivityResult.none:
        hasConnection = false;
        //connectionChangeController!.add(false);
        connectionChangeController!.sink.add(false);
        break;
      default:
        hasConnection = true;
        //connectionChangeController!.sink.add(true);
        print('ko co internet ');
        //  print('default internet $internetAvailable ');
        break;
    }
  }

  //The test to actually see if there is a connection
  Future<bool> _checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      //  connectionChangeController!.add(hasConnection);
    }

    return hasConnection;
  }
}
Connection connection =  Connection();