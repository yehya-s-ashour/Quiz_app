import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/pages/true_false_q_screen.dart';

import '../constants.dart';
import '../widgets/my_outline_btn.dart';

class LevelDescription extends StatelessWidget {
  const LevelDescription({Key? key,required this.routeName,required this.titleQuestion , required this.color , required this.subTitle , required this.imageSource}) : super(key: key);
  final String titleQuestion ;
  final String subTitle ;
  final String imageSource ;
  final List<Color> color ;
final String routeName ;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors:  color,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 74, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 44,
                    width: 44,
                    child: MYOutlineBtn(
                      icon: Icons.close,
                      iconColor: Colors.white,
                      bColor: Colors.white,
                      function: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: Image.asset(imageSource),
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white60,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                titleQuestion ,
                style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () {
                   Navigator.pushNamed(context, routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  child: const Center(
                    child: Text(
                      'Game',
                      style: TextStyle(
                          color: kL2,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
