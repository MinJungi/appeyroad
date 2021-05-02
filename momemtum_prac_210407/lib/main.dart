import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        )
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: BackGround(
        imagePath: 'images/mountains-6043079.jpg',
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Links(),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Weather(),
              ),
              Align(
                alignment: Alignment.center,
                child: Clock(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Setting(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Quotes(),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Todo(),
              ),
              Align(
                alignment: FractionalOffset(0.5, 0.8),
                child : Focus(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BackGround extends StatelessWidget {
  final Widget child;
  final String imagePath;

  BackGround({this.child, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          )
      ),
      child: child,
    );
  }
}

class Links extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Links"),
        Container(height: 0, width: 10,),
        Icon(Icons.search, color: Colors.white,),
      ],
    );
  }
}

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.wb_sunny_outlined, color: Colors.white,),
        Container(height: 0, width: 10,),
        Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              Text("14º", style: TextStyle(fontSize: 20),),
              Text("Seoul", style: TextStyle(fontSize: 10),),
            ],
        )
      ],
    );
  }
}

/*
class Clock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*return Column(
      children: [
        Flexible(child: Container(),),
        Text("15:49", style: TextStyle(fontSize: 150,),),
        Flexible(child: Center(child: Focus())),
      ],
    );*/
    return Text("17:30", style: TextStyle(fontSize: 150),);
  }
}
*/

class Clock extends StatefulWidget {
  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String _timeString;
  Timer _timer;

  String _formatDateTime(DateTime dateTime){
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  void _getTime(){
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer t) => _getTime());
    
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(_timeString, style: TextStyle(fontSize: 150),);
  }
}

/*
class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //PopupMenuButton(itemBuilder: itemBuilder),
        Icon(Icons.settings, color: Colors.white,)
      ],
    );
  }
}*/


class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  void showPopup(){
    showDialog(context: context, builder: (_) => PopUp());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Icon(Icons.settings, color:Colors.white),
        FloatingActionButton(
          onPressed: showPopup,
          backgroundColor: Color(0x00000000),
          //shape: ,
          child: Icon(Icons.settings, color: Colors.white,),
        )
      ],
    );
  }
}

class PopUp extends StatefulWidget {
  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> with TickerProviderStateMixin {
  AnimationController controller;
  double _bottom = 0, _fromTop=300, _screenHeight, _containerHeight = 300;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this)
      ..addListener(() {
        Timer.periodic(Duration(milliseconds: 15), (timer) {
          if(_bottom < _screenHeight - _fromTop - _containerHeight){
            _bottom += 1;
            setState(() {

            });
          }
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            bottom: _bottom,
            left: 0,
            right: 0,
            child: Container(height: _containerHeight, color: Colors.blue,)
          )
        ],
      ),
      //color: Colors.blue,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}



class Quotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('"Always walk through life as if you have something new to learn nad you will."');
  }
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Todo");
  }
}

class Focus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("What is your main focus for today?", style: TextStyle(fontSize: 30),),
          TextField(
            enabled: true,
            decoration: InputDecoration(
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


