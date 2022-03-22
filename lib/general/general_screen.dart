import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../helper/connection.dart';

abstract class GeneralScreen<T extends StatefulWidget> extends State<T> {
  Connection? connectionStatus;
  bool isOnline = true;
  bool internetChanged = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  void initState() {

    super.initState();
    _checkInternet();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }
  _checkInternet() async {
    connectionStatus = Connection();
  await  connectionStatus!.checkConnection().then((isConnect) {
      print('isConnect $isConnect');
          if (mounted)
            {
              setState(() {
                isOnline = isConnect;
              });
            }
        });
  }

  _handleInternet() async {
    if (connectionStatus != null) {
      connectionStatus!.dispose();
    }
    // connectionStatus = Connection.getInstance(); todo bị duplicate listen
    connectionStatus = Connection();
    connectionStatus!.initialize();
    connectionStatus!.connectionChange.listen((event) {
      print('event $event');
      if (mounted) {
        setState(() {
          isOnline = event;
        });
      }
      print('isOnline $isOnline');
    });
  }

  @override
  void dispose() {
    print('GeneralScreen dispose');
    if (connectionStatus != null) {
      connectionStatus!.dispose();
    }
    super.dispose();
  }
}
