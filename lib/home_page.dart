import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mariotutorial/buttons.dart';
import 'package:mariotutorial/Movement/jumpingmario.dart';
import 'package:mariotutorial/Movement/marioimage.dart';

import 'Movement/mushroom.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double marioX = 0;
  static double marioY = 1;
  double marioSize = 50;
  double time = 0;
  double intialheight = marioY;
  double height = 0;
  String direction = 'right';
  bool midrun = false;
  bool midjump = false;
  static double mushroomX = 0.5;
  static double mushroomY = 1;

  void isCheckMushroom() {
    if ((marioX - mushroomX).abs() < 0.05 &&
        (marioY - mushroomY).abs() < 0.05) {
      setState(() {
        // if eaten, move the  mushroom screen
        mushroomY = 2;
        marioSize = 100;
      });
    }
  }

  void prejump() {
    time = 0;
    intialheight = marioY;
  }

  void jump() {
    if (midjump == false) {
      midjump = true;
      prejump();
      Timer.periodic(Duration(milliseconds: 50), (timer) {
        time += 0.05;
        height = -4.9 * time * time + 5 * time;
        if (intialheight - height > 1) {
          midjump = false;
          setState(() {
            marioY = 1;
          });
          timer.cancel();
        } else {
          setState(() {
            marioY = intialheight - height;
          });
        }
      });
    }
  }

  void moveRight() {
    direction = 'right';
    isCheckMushroom();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      isCheckMushroom();
      if (MyButton().userIsHoldingButton() == true && (marioX + 0.02) < 1) {
        setState(() {
          marioX += 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void moveLeft() {
    direction = 'left';
    isCheckMushroom();
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      isCheckMushroom();
      if (MyButton().userIsHoldingButton() == true && (marioX - 0.02) >-1) {
        setState(() {
          marioX -= 0.02;
          midrun = !midrun;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 4,
              child: Stack(children: [
                Container(
                    color: Colors.blue,
                    child: AnimatedContainer(
                      duration: Duration(microseconds: 0),
                      alignment: Alignment(marioX, marioY),
                      child: midjump
                          ? JumpingMario(
                              size: marioSize,
                            )
                          : MyMario(
                              direction: direction,
                              midRun: midrun,
                              size: marioSize,
                            ),
                    )),
                Container(
                    alignment: Alignment(mushroomX, mushroomY),
                    child: Mushroom()),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Mario',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('0000',
                              style: Theme.of(context).textTheme.headline3)
                        ],
                      ),
                      Column(
                        children: [
                          Text('Word',
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(
                            height: 10,
                          ),
                          Text('1-1',
                              style: Theme.of(context).textTheme.headline3)
                        ],
                      ),
                      Column(
                        children: [
                          Text('Time',
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(
                            height: 10,
                          ),
                          Text('999',
                              style: Theme.of(context).textTheme.headline3)
                        ],
                      )
                    ],
                  ),
                )
              ])),
          Expanded(
              flex: 1,
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      function: moveLeft,
                    ),
                    MyButton(
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                      function: jump,
                    ),
                    MyButton(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      function: moveRight,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
