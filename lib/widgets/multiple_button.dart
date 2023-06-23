import 'package:flutter/material.dart';

import '../constants.dart';


class MultipleButton extends StatelessWidget {
  const MultipleButton({
    required this.onPressed,
    required this.title,
     this.backgroundColor = Colors.white,
    super.key,
  });

  final String title ;
  final Function() onPressed ;
 final Color backgroundColor ;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: Row(
          children: [
            const  SizedBox(
              width: 24,
            ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style:const TextStyle(
                      color: kL2,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
