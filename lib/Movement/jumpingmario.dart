import 'package:flutter/material.dart';


class JumpingMario extends StatelessWidget {
  double size;

JumpingMario({this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Image.asset('image/jumpingmario.png'),
    );
  }
}
