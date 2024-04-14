import 'package:flutter/material.dart';

class InkWellWidget extends StatelessWidget {
  final Widget child;
  final Function onTap;

  const InkWellWidget({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: child,
      onTap: () {
        onTap();
      },
    );
  }
}
