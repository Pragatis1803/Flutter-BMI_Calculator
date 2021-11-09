import 'dart:math';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'container_box.dart';
import 'data_container.dart';
import 'package:flutter_bmi_calculator/prefs/style.dart';
import 'package:flutter_bmi_calculator/prefs/theme_provider.dart';
import 'package:provider/provider.dart';

const activeColor = Color(0xFF566de5);
const inActiveColor = Color(0xFFffffff);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Color maleBoxColor = activeColor;
  Color femaleBoxColor = inActiveColor;
  int height = 180;
  int weight = 20;
  int age = 25;
  String result = "";
  String resultDetail = "Result here";
  double bmi = 0;
  bool switchValue = false;
  ThemeProvider themeProvider = ThemeProvider();

  void updateBoxColor(int gender) {
    if (gender == 1) {
      if (maleBoxColor == inActiveColor) {
        maleBoxColor = activeColor;
        femaleBoxColor = inActiveColor;
      } else {
        maleBoxColor = inActiveColor;
        femaleBoxColor = activeColor;
      }
    } else {
      if (femaleBoxColor == inActiveColor) {
        maleBoxColor = inActiveColor;
        femaleBoxColor = activeColor;
      } else {
        maleBoxColor = activeColor;
        femaleBoxColor = inActiveColor;
      }
    }
  }

  String calculateBmi(int weight, int height) {
    bmi = weight / pow((height / 100), 2);
    return bmi.toStringAsFixed(1);
  }

  String getInterpretation(double bmi) {
    if (bmi >= 25.0) {
      return "You have a higher than normal body weight. Try to exercise more. ";
    } else if (bmi > 18.5) {
      return "You have a normal body weight. Good job!";
    } else {
      return "You have a lower than normal body weight. You can eat a bit more";
    }
  }

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Style.themeData(themeProvider.darkTheme),
              home: Scaffold(
                appBar: AppBar(
                  // ignore: prefer_const_constructors
                  title: Text("BMI Calculator"),
                ),
                // ignore: prefer_const_constructors
                body: Column(
                  // ignore: prefer_const_constructors
                  children: <Widget>[
                    // ignore: prefer_const_constructors
                    Switch(
                      value: switchValue,
                      onChanged: (val) {
                        themeProvider.darkTheme = !themeProvider.darkTheme;
                        setState(() {
                          switchValue = val;
                        });
                      },
                    ),
                    Expanded(
                        child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        // ignore: prefer_const_constructors
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                updateBoxColor(1);
                              });
                            },
                            child: ContainerBox(
                              // ignore: prefer_const_constructors
                              boxColor: maleBoxColor,
                              // ignore: prefer_const_constructors
                              childWidget: DataContainer(
                                icon: FontAwesomeIcons.mars,
                                title: 'MALE',
                              ),
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                updateBoxColor(2);
                              });
                            },
                            child: ContainerBox(
                              // ignore: prefer_const_constructors
                              boxColor: femaleBoxColor,
                              childWidget: DataContainer(
                                icon: FontAwesomeIcons.venus,
                                title: 'FEMALE',
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                    // ignore: prefer_const_constructors
                    Expanded(
                      // ignore: prefer_const_constructors
                      child: ContainerBox(
                        // ignore: prefer_const_constructors
                        boxColor: inActiveColor,
                        childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // ignore: prefer_const_constructors
                            Text(
                              'HEIGHT',
                              style: textStyle1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                // ignore: prefer_const_constructors
                                Text(
                                  height.toString(),
                                  style: textStyle2,
                                ),
                                // ignore: prefer_const_constructors
                                Text(
                                  'cm',
                                  style: textStyle1,
                                ),
                              ],
                            ),
                            Slider(
                              value: height.toDouble(),
                              min: 120,
                              max: 220,
                              activeColor: activeColor,
                              inactiveColor: inActiveColor,
                              onChanged: (double newValue) {
                                setState(() {
                                  height = newValue.round();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        // ignore: prefer_const_constructors
                        Expanded(
                          // ignore: prefer_const_constructors
                          child: ContainerBox(
                            // ignore: prefer_const_constructors
                            boxColor: inActiveColor,
                            childWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                // ignore: prefer_const_constructors
                                Text(
                                  'WEIGHT',
                                  style: textStyle1,
                                ),
                                Text(
                                  weight.toString(),
                                  style: textStyle2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_constructors
                                  children: <Widget>[
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          weight++;
                                        });
                                      },
                                      backgroundColor: activeColor,
                                      // ignore: prefer_const_constructors
                                      child: Icon(FontAwesomeIcons.plus,
                                          color: Colors.white),
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          if (weight > 0) {
                                            weight--;
                                          }
                                        });
                                      },
                                      backgroundColor: activeColor,
                                      // ignore: prefer_const_constructors
                                      child: Icon(FontAwesomeIcons.minus,
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        // ignore: prefer_const_constructors
                        Expanded(
                          // ignore: prefer_const_constructors
                          child: ContainerBox(
                            // ignore: prefer_const_constructors
                            boxColor: inActiveColor,
                            childWidget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: <Widget>[
                                // ignore: prefer_const_constructors
                                Text(
                                  'AGE',
                                  style: textStyle1,
                                ),
                                Text(
                                  age.toString(),
                                  style: textStyle2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: prefer_const_constructors,
                                  children: <Widget>[
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          age++;
                                        });
                                      },
                                      backgroundColor: activeColor,
                                      // ignore: prefer_const_constructors
                                      child: Icon(FontAwesomeIcons.plus,
                                          color: Colors.white),
                                    ),
                                    // ignore: prefer_const_constructors
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          if (age > 0) {
                                            age--;
                                          }
                                        });
                                      },
                                      backgroundColor: activeColor,
                                      // ignore: prefer_const_constructors
                                      child: Icon(FontAwesomeIcons.minus,
                                          color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),

                    GestureDetector(
                        onTap: () {
                          setState(() {
                            result = calculateBmi(weight, height);
                            resultDetail = getInterpretation(bmi);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    backgroundColor: inActiveColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Container(
                                      color: inActiveColor,
                                      height: 200.0,
                                      // ignore: prefer_const_constructors
                                      margin: EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: <Widget>[
                                          // ignore: prefer_const_constructors
                                          Text(
                                            'Result',
                                            style: textStyle1,
                                          ),
                                          // ignore: prefer_const_constructors
                                          Text(
                                            result.toString(),
                                            style: textStyle2,
                                          ),
                                          // ignore: prefer_const_constructors
                                          Text(
                                            resultDetail,
                                            style: textStyle1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          });
                        },
                        child: Container(
                          // ignore: prefer_const_constructors
                          child: Center(
                            // ignore: prefer_const_constructors
                            child: Text(
                              'Calculate',
                              style: textStyle3,
                            ),
                          ),
                          // ignore: prefer_const_constructors

                          width: double.infinity,
                          height: 80.0,
                          color: activeColor,
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.only(top: 10.0),
                        )),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
