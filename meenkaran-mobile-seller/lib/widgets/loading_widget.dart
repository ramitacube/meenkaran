import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(36),
      child: Align(
        alignment: Alignment.topCenter,
        child: CircularProgressIndicator(),
        heightFactor: 0,
      ),
    );
  }
}
