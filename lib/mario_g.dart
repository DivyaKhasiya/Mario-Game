import 'dart:math';

import 'package:flutter/material.dart';

class MyMario extends StatelessWidget {
  final String direction;
  final bool midRun;
  final double size;

  MyMario({this.direction,this.midRun,this.size});


  @override
  Widget build(BuildContext context) {
     if(direction=='right'){
      return Container(
        width: size,
        height: size,
        child: midRun?Image.asset('image/standingmario.png'):
        Image.network('https://vignette.wikia.nocookie.net/fantendo/images/1/1a/Mario_run.png/revision/latest?cb=20100714182643')
      );
    }
     else{
       return Transform(
         alignment: Alignment.center,
         transform: Matrix4.rotationY(pi),
         child: Container(
           width: size,
           height: size,
           child: midRun?Image.asset('image/standingmario.png'):
           Image.network('https://vignette.wikia.nocookie.net/fantendo/images/1/1a/Mario_run.png/revision/latest?cb=20100714182643')
         ),
       );
     }
  }
}
