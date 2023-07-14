
import 'package:multi_quiz_s_t_tt9/modules/true_false/quizBrain.dart';
import 'package:flutter/material.dart';
mixin Helpers  {

  QuizBrain quizBrain = QuizBrain();

  void showQuizFinishedDialog(BuildContext context , int score , int counter , int questionSize) {
    showDialog(
      barrierDismissible: false,

      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: score>=(questionSize/2)?Colors.green :Colors.red.shade400,
          title: const Text('Quiz Finished',style: TextStyle(color: Colors.white),),
          content:  Text(
            '${score>=(questionSize/2)?'Congratulations!':'Better luck next'} You have completed the quiz. $score / $questionSize',
            style:const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                counter = 10 ;
                score = 0 ;

                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Close',style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }





}