import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    Key key,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 6),
      width: isActive ? 22 : 18,
      height: isActive ? 8 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey.withOpacity(0.6),
          borderRadius: BorderRadius.circular(15)),
      duration: Duration(milliseconds: 500),
    );
  }
}
