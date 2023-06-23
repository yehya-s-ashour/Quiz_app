
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
          title: const Text('Quiz Finished'),
          content:  Text(
            'Congratulations! You have completed the quiz. $score / $questionSize',
            style:const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                counter = 10 ;
                score = 0 ;

                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }





}