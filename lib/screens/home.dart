import 'package:flutter/material.dart';
import 'package:internet/general/general_screen.dart';

import 'other_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends GeneralScreen<HomeScreen> {
  String? connected='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Internet'),),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                InkWell(child:  Text('$connected'),onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OtherScreen()),
                  );
                },)
            ],
          ),
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
