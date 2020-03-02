import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import './Survey2.dart';
//import 'images';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orangeAccent),
      home: Survey(),
    );
  }
}

class Survey extends StatefulWidget {
  @override
  SurveyState createState() {
    // TODO: implement createState
    return SurveyState();
  }
}

class SurveyState extends State<Survey>
    with TickerProviderStateMixin {
  AnimationController _animateController;
  AnimationController _longPressController;
  AnimationController _secondStepController;
  AnimationController _thirdStepController;


  double overall = 3.0;
  String overallStatus = "Good";
  int curIndex = 0;
  String usingTimes = 'Daily';

  bool isservise = false;
  bool isplace = false;
  bool isfast = false;
  bool isrestaurant = false;

  List<SecondQuestion> usingCollection = [
    SecondQuestion('daily', 'Daily'),
    SecondQuestion('Afivepw', 'About 5 times per week'),
    SecondQuestion('Rarely', 'Rarely'),
    SecondQuestion('never', 'Never'),
    SecondQuestion('other', 'Other'),
    
  ];

  Animation<double> longPressAnimation;
  Animation<double> secondTranformAnimation;
  Animation<double> thirdTranformAnimation;
  // Animation<double> fourTranformAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _longPressController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _secondStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _thirdStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    longPressAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
            parent: _longPressController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));


    secondTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _secondStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    thirdTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _thirdStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _longPressController.addListener(() {
      setState(() {});
    });

    _secondStepController.addListener(() {
      setState(() {});
    });

    _thirdStepController.addListener(() {
      setState(() {});
    });

    
    
    
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animateController.dispose();
    _secondStepController.dispose();
    _thirdStepController.dispose();
 
    _longPressController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startLongPressAnimation() async {
    try {
      await _longPressController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startSecondStepAnimation() async {
    try {
      await _secondStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  Future _startThirdStepAnimation() async {
    try {
      await _thirdStepController.forward().orCancel;
    } on TickerCanceled {}
  }


  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 32.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted
          ? BottomAppBar(
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
              height: 50.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    curIndex += 1;
                    if (curIndex == 1) {
                      _startThirdStepAnimation();
                    } else if (curIndex == 2) {
                      _startSecondStepAnimation();
                    } else if (curIndex == 3) {
                      _startThirdStepAnimation();
                    }
                  });
                },
                child: Center(
                    child: Text(
                  curIndex < 3 ? 'Continue' : 'Finish',
                  style: TextStyle(fontSize: 20.0, color: Colors.orangeAccent),
                )),
              ),
            ))
          : null,
    );
  }

  Widget getPages(double _width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
//                color: Colors.blue,
          margin: EdgeInsets.only(top: 30.0),
          height: 10.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(4, (int index) {
              return Container(
                decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
                  color: index <= curIndex ? Colors.orangeAccent : Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                ),
                height: 10.0,
                width: (_width - 32.0 - 15.0) / 4.0,
                margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
              );
            }),
          ),
        ),
        curIndex == 0
            ? _getFirstStep()
            : curIndex == 2
                ? _getSecondStep()
                : curIndex ==  1? _getThirdStep() :_getFourthStep()
                
      ],
    );
  }

  Widget _getFirstStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Question 1'),
            Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text('Overall, how would you rate food ordering service in Egypt?')),
            Container(
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                overallStatus,
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Center(
                child: Slider(
                  value: overall,
                  onChanged: (value) {
                    setState(() {
                      overall = value.round().toDouble();
                      print("overall"+overall.toString());
                      _getOverallStatus(overall);
                    });
                  },
                  label: '${overall.toInt()}',
                  divisions: 5,
                  min: 1.0,
                  max: 5.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getSecondStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - secondTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: secondTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 3'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('How often do you typically use food ordering service?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 258.0,
                      child: Card(
                        child: Column(
                          children: List.generate(usingCollection.length,
                              (int index) {
                            final using = usingCollection[index];
                            return GestureDetector(
                              onTapUp: (detail) {
                                setState(() {                           
                                  usingTimes = using.identifier;
                                  print("usingTimes"+usingTimes);
                                });
                              },
                              child: Container(
                                height: 50.0,
                                color: usingTimes == using.identifier
                                    ? Colors.orangeAccent.withAlpha(100)
                                    : Colors.white,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                            activeColor: Colors.orangeAccent,
                                            value: using.identifier,
                                            groupValue: usingTimes,
                                            onChanged: (String value) {
                                              setState(() {
                                                usingTimes = value;
                                              });
                                            }),
                                        Text(using.displayContent)
                                      ],
                                    ),
                                    Divider(
                                      height: index < usingCollection.length
                                          ? 1.0
                                          : 0.0,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


/// third question is the question 2  /// 
/// 
/// seconed Question is the question 3/// 



///FirstQuestion 
///     overallStatus 
///Second Question 
/// AnswerNumber
///Thirdquestion
///usingTimes
///fourth Question 
/// AnswerNumber
 
 
  List<ThirdQuestion> thirdQuestionList = [
    ThirdQuestion('coustmer service', false,0),
    ThirdQuestion('Crowding', false,1),
    ThirdQuestion('Waiting', false,2),
    ThirdQuestion('Quality', false,3),
  ];
  Widget _getThirdStep() {
    return Expanded(
      
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - thirdTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: thirdTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 2'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('Overall, what are the common problems you face while ordering food?')),
                Expanded(
                  child: Center(
                    child: Container(
                      height: 213.0,
                      child: Card(
                        child: Column(
                          children: List.generate(thirdQuestionList.length,
                              (int index) {
                            ThirdQuestion question = thirdQuestionList[index];
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTapUp: (detail) {
                                    setState(() {
                                      question.answerNumber=index;
                                      print(question.answerNumber.toString()+"index");
                                      question.isSelected =
                                          !question.isSelected;
//                                  isFairly = !isFairly;
                                    });
                                  },
                                  child: Container(
                                    height: 50.0,
                                    color: question.isSelected
                                        ? Colors.orangeAccent.withAlpha(100)
                                        : Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: Colors.orangeAccent,
                                            value: question.isSelected,
                                            onChanged: (bool value) {
//                                          print(value);
                                              setState(() {
                                                question.isSelected = value;
                                              });
                                            }),
                                        Text(question.displayContent)
                                        
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: index < thirdQuestionList.length
                                      ? 1.0
                                      : 0.0,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

/// fourth_Question

List<FourthQuestion> fourthQuestionList = [
    FourthQuestion('Macdonald', false,0),
    FourthQuestion('KFC', false,1),
    FourthQuestion('Burger King', false,2),
    FourthQuestion('Pizza Hut', false,3),
    FourthQuestion('Dominos Pizza', false,4),
    FourthQuestion('Other', false,5),

  ];
  Widget _getFourthStep() {
    return Expanded(
      child: Container(
        // height: MediaQuery.of(context).size.height*(0.80/fourthQuestionList.length),
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - thirdTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: thirdTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Question 4'),
                Container(
                    margin: EdgeInsets.only(top: 16.0),
                    child: Text('What are the usual resturants that you prefer to order From?')),
                Expanded(
                  child: Center(
                    child: Container(
                      // height: MediaQuery.of(context).size.height,
                      
                      child: Card(
                        child: Column(
                          children: List.generate(fourthQuestionList.length,
                              (int index) {
                            FourthQuestion question = fourthQuestionList[index];
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTapUp: (detail) {
                                    setState(() {
                                      question.answerNumber=index;
                                      print(question.answerNumber.toString()+"index");
                                      question.isSelected =
                                          !question.isSelected;
//                                  isFairly = !isFairly;
                                    });
                                     if(index==5)
                                     {
                                       
                                       showDialog(
                                        context: context,

                                        builder: (_) => new AlertDialog(
                                          
                                            title: new Text("Other"),
                                            content:Container(
                                              height: MediaQuery.of(context).size.height*0.15,
                                              child:
                                                 Column(children: <Widget>[
                                              TextField(
                                               onSubmitted: (value){
                                                setState(() {
                                                  // add to database 
                                                });
                                              },
                                            ),
                                            FlatButton(onPressed:(){Navigator.pop(context);} , child: 
                                            
                                            Text("OK"))

                                            ],))
                                       
                                            
                                        )
                                    );} 
                                    
                                  },
                                  child: Container(
                                    height: 50.0,
                                    color: question.isSelected
                                        ? Colors.orangeAccent.withAlpha(100)
                                        : Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: Colors.orangeAccent,
                                            value: question.isSelected,
                                            onChanged: (bool value) {
//                                          print(value);
                                              setState(() {
                                                question.isSelected = value;
                                              });
                                            }),
                                        Text(question.displayContent)
                                        
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: index < fourthQuestionList.length
                                      ? 1.0
                                      : 0.0,
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }




















  _getOverallStatus(double overall) {
    switch (overall.toInt()) {
      case 1:
        overallStatus = 'Bad';
        break;
      case 2:
        overallStatus = 'Normal';
        break;
      case 3:
        overallStatus = 'Good';
        break;
      case 4:
        overallStatus = 'Very Good';
        break;
      default:
        overallStatus = 'Excellent';
        break;
    }
  }
}

class AnimationBox extends StatelessWidget {
  AnimationBox(
      {Key key, this.controller, this.screenWidth, this.onStartAnimation})
      : width = Tween<double>(
          begin: screenWidth,
          end: 40.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.3,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        alignment = Tween<AlignmentDirectional>(
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topStart,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = BorderRadiusTween(
          begin: BorderRadius.circular(20.0),
          end: BorderRadius.circular(2.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 40.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        movement = EdgeInsetsTween(
          begin: EdgeInsets.only(top: 0.0),
          end: EdgeInsets.only(top: 30.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        scale = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        numberOfStep = IntTween(
          begin: 1,
          end: 4,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  final VoidCallback onStartAnimation;
  final Animation<double> controller;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<AlignmentDirectional> alignment;
  final Animation<BorderRadius> radius;
  final Animation<EdgeInsets> movement;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<int> numberOfStep;
  final double screenWidth;
  final double overral = 3.0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          alignment: alignment.value,
          children: <Widget>[
            Opacity(
              opacity: 1.0 - opacity.value,
              child: Column(
                children: <Widget>[
                  Container(
//                color: Colors.blue,
                    margin: EdgeInsets.only(top: 30.0),
                    height: 10.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(numberOfStep.value, (int index) {
                        return Container(
                          decoration: BoxDecoration(
//                    color: Colors.orangeAccent,
                            color:
                                index == 0 ? Colors.orangeAccent : Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          height: 10.0,
                          width: (screenWidth - 15.0) / 5.0,
                          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
//                color: Colors.blue,
                      margin: EdgeInsets.only(top: 34.0),
//                height: 10.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Question 1'),
                          Container(
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text(
                                  'Overall, how would you rate our service?')),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 50.0),
                            child: Text(
                              'Good',
                              style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity:
                  controller.status == AnimationStatus.dismissed ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset('images/Tempologo.jpeg', width: MediaQuery.of(context).size.width * 0.35, height: MediaQuery.of(context).size.height * 0.55 ),
                  Text(
                    'Your opinion matters.',
                    style: TextStyle(
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 120.0),
                    child: Text(
                      'By answering this 3 minutes survey, you help us improve our service even better for you',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Opacity(
              opacity: opacity.value,
              child: GestureDetector(
                onTap: onStartAnimation,
                child: Transform.scale(
                  scale: scale.value,
                  child: Container(
                    margin: movement.value,
                    width: width.value,
                    child: GestureDetector(
                      child: Container(
                        height: height.value,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: radius.value),
                        child: Center(
                          child: controller.status == AnimationStatus.dismissed
                              ? Text(
                                  'Take the survey',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
//            Opacity(
//              opacity: 1.0 - opacity.value,
//              child:
//            ),
          ],
        );
      },
    );
  }
}

class SecondQuestion {
  final String identifier;
  final String displayContent;

  SecondQuestion(this.identifier, this.displayContent);
}

class ThirdQuestion {
  final String displayContent;
  bool isSelected;
  int answerNumber;
  ThirdQuestion(this.displayContent, this.isSelected,this.answerNumber);
}

class FourthQuestion {
  final String displayContent;
  bool isSelected;
  int answerNumber;
  FourthQuestion(this.displayContent, this.isSelected,this.answerNumber);
}