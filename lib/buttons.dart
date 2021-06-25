import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final child;
  final function;
  static bool holdingButton = false;
  const MyButton({this.child, this.function});

  bool userIsHoldingButton() {
    return holdingButton;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        holdingButton = true;
        function();
      },
      onTapUp: (details){
        holdingButton=false;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.brown[300],
          padding: EdgeInsets.all(10),
          child: child,
        ),
      ),
    );
  }
}
