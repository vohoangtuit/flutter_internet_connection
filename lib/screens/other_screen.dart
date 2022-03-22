import 'package:flutter/material.dart';
import 'package:internet/general/general_screen.dart';

class OtherScreen extends StatefulWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  State<OtherScreen> createState() => _OtherScreenState();
}

class _OtherScreenState extends GeneralScreen<OtherScreen> {
  String? connected='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Other Screen'),),
      body: Center(
        child: Container(
          child: Text('$connected'),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if(isOnline){
        setState(() {
          connected ='Connected';
        });
        _getData();
      }else{
        setState(() {
          connected ='Disconnected';
        });
      }
    });
  }
  _getData(){
    print(' Home get data');
  }
}
