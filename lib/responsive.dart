import 'package:flutter/material.dart';
class Responsive extends StatelessWidget {
  const Responsive({Key? key,
  required this.destop,
  required this.mobile
  }) : super(key: key);
final Widget mobile;
final Widget destop;
static bool ismobile(BuildContext context){
  return MediaQuery.of(context).size.width < 850;
}
static bool isDestop(BuildContext context) =>
    MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {

    final Size _size = MediaQuery.of(context).size;
    if(_size.width >=1100){ return destop;}
    else return mobile;
  }
}
