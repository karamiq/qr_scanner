import 'package:flutter/material.dart';

class ScanSpotClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var h = size.height;
    var w = size.width;
    Path path = Path();
    //path.moveTo(0, h * .1);

    path.lineTo(w * .0, h * .8);
    final ps2 = Offset(0, h);
    final pe2 = Offset(w * .2, h);
    path.quadraticBezierTo(ps2.dx, ps2.dy, pe2.dx, pe2.dy);

    path.lineTo(w * .93, h);

    final ps3 = Offset(w, h * .96);
    final pe3 = Offset(w * .93, h * .92);
    path.quadraticBezierTo(ps3.dx, ps3.dy, pe3.dx, pe3.dy);
    final ps5 = Offset(0, h);
    final pe5 = Offset(w * .08, h * .1);
    path.quadraticBezierTo(ps5.dx, ps5.dy, pe5.dx, pe5.dy);

    final ps4 = Offset(w * .04, h * .02);
    final pe4 = Offset(0, h * .1);
    path.quadraticBezierTo(ps4.dx, ps4.dy, pe4.dx, pe4.dy);

    // path.lineTo(w, h);
    // final ps5 = Offset(0, h * .5);
    // final pe5 = Offset(0, 0);
    // path.quadraticBezierTo(ps5.dx, ps5.dy, pe5.dx, pe5.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
