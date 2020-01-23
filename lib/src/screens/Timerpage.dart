import 'package:drive_thru/src/screens/OldDashboard.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'dart:core';
import 'package:drive_thru/src/screens/AddResturant.dart';
import 'package:drive_thru/src/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import 'Dashboard.dart';



void main() => runApp(MaterialApp(
      home: TimerPage(),
      theme: ThemeData(
        canvasColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.pinkAccent,
        brightness: Brightness.dark,
      ),
    ));

class TimerPage extends StatefulWidget {
  @override
  TimerPage({Key key}) : super(key: key);
  TimerPageState createState() => TimerPageState();
}

class TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  AnimationController controller;

  //bool isPlaying = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  
  }

  set _controller(TickerFuture _controller) {}


  @override
  void initState() {

      super.initState();
       controller = AnimationController(
      
      vsync: this,
      duration: Duration(seconds: 10),
      
    );

    
    _controller=controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
       backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,          
          backgroundColor: primaryColor,
          title:
              Text('Virtual DriveThru', style: logoWhiteStyle, textAlign: TextAlign.center),
          actions: <Widget>[
            FlatButton(

                onPressed: () {
                  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: DashBoard()));
                  },
                color: primaryColor,
                padding: EdgeInsets.all(2),
               shape: CircleBorder(),
                child: Icon(Icons.home, color: white, size: 25,),
            
            ),],),
            drawer :Drawer(child: ListView (
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Virtual Drive Thru', style: logoWhiteStyle, textAlign: TextAlign.center,),
              decoration: BoxDecoration(
                color: Colors.orange,
                
              ),
            ),
            ListTile(
              title: Text('Home Page'),
              onTap: () {
                 Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: DashBoard()));
              },
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () {

              },
            ),
            ListTile(
              title: Text('My Cart'),
              onTap: () {
                
              },
            ),ListTile(
              title: Text('Add Restaurant'),
              onTap: () {
                Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: AddResturant()));
              },
            ),ListTile(
              title: Text('Settings'),
              onTap: () {
              },
            ),ListTile(
              title: Text('Timer Page'),
              onTap: () {
                 Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: TimerPage()));
              },
            ),
              ListTile(
              title: Text('Sign Out'),
              onTap: () {
                FirebaseAuth.instance.signOut().then((value){
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.leftToRightWithFade, child: HomePage()));
                    }).catchError((e){print(e);});
              },
            ),
          ],
        ),
        ),
      body: Padding(
        padding: EdgeInsets.all(1.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return CustomPaint(
                                painter: TimerPainter(
                              animation: controller,
                              backgroundColor: Colors.white,
                              color: themeData.indicatorColor,
                            ));
                          },
                        ),
                      ),
                      Align(
                        alignment: FractionalOffset.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Your Order is Ready in: ",
                              style: themeData.textTheme.subhead,
                            ),
                            AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  return Text(
                                    timerString,
                                    style: themeData.textTheme.display4,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              
              margin: EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}