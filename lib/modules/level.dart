import 'package:flutter/cupertino.dart';

class Level {

  final String title;
  final String subTitle ;
  final String? descrption ;
  final String? image ;
  final IconData? iconData ;
  final List<Color> colors ;
  final String routeName ;



  Level({
    required this.title ,
    required this.subTitle ,
    required this.colors ,
    required this.routeName ,
    this.iconData,
    this.descrption,
    this.image
  });






}