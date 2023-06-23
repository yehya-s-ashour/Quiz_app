import 'package:flutter/material.dart';

import 'my_outline_btn.dart';


class QuizAppBarRow extends StatelessWidget {
  const QuizAppBarRow({
    super.key,
    required this.counter,
    required this.pageNameWidget,
  });

  final int counter;
final Widget pageNameWidget ;
  @override
  Widget build(BuildContext context) {
    return Row(
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
              // Navigator.pop(context);
              // Navigator.pop(context);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>pageNameWidget,
                ),
                    (route) => false,
              );
            },
          ),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 56,
              width: 56,
              child: CircularProgressIndicator(
                value: counter / 10 ,
                color: Colors.white,
                backgroundColor: Colors.white12,
              ),
            ),
            Text(
              counter.toString(),
              style:const TextStyle(
                fontFamily: 'Sf-Pro-Text',
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              side:const BorderSide(color: Colors.white)),
          child:const Icon(
            Icons.favorite,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}