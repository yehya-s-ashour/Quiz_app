import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/Helpers.dart';
import 'package:multi_quiz_s_t_tt9/modules/multipe_choice/quizBrainMultiple.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

import '../constants.dart';
import '../widgets/multiple_button.dart';

class MultiQScreen extends StatefulWidget {
  const MultiQScreen({Key? key}) : super(key: key);

  @override
  State<MultiQScreen> createState() => _MultiQScreenState();
}

class _MultiQScreenState extends State<MultiQScreen> with Helpers {
  List<Icon> scoreKeeper = [];

  int counter = 10;
  int score = 0;
  QuizBrainMulti quizBrainMulti = QuizBrainMulti();
  int questionNumber = 1;

  bool isAnswered = false;
  bool answerSelected = false;


 late Timer _timer ;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          //timer.cancel();
        //  showQuizFinishedDialog(context);
          goToNextQuestion();
          //checkAnswer(-1);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  void checkAnswer(int userChoice) {
    int correctAnswer = quizBrainMulti.getQuestionAnswer();
    bool isCorrect = userChoice == correctAnswer;
    setState(() {
      answerSelected = true;
      isAnswered = true;
      if (isCorrect) {
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
        score++;
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });

    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        isAnswered = false;
      });
      if (isCorrect) {
        goToNextQuestion();
      } else {
        goToNextQuestion();
        //counter = 10;
      }
    });
  }

  void goToNextQuestion() {
    if (quizBrainMulti.isFinished()) {
    _timer.cancel();
      showQuizFinishedDialog(context,score,counter,quizBrainMulti.getLength());
    } else {
      setState(() {
        counter = 10;
        questionNumber++;
        answerSelected = false;
        quizBrainMulti.nextQuestion();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    int questionLength = quizBrainMulti.getLength();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              kBlueBg,
              kL2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
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
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
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
                          value: counter / 10,
                          color: Colors.white,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                      Text(
                        counter.toString(),
                        style: const TextStyle(
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
                        side: const BorderSide(color: Colors.white)),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/ballon-b.png'),
                ),
              ),
              Text(
                'question $questionNumber of $questionLength',
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
                quizBrainMulti.getQuestionText(),
                style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              MultipleButton(
                title: quizBrainMulti.getOptions().elementAt(0),
                onPressed: isAnswered ? (){} : () => checkAnswer(0),
                backgroundColor: answerSelected && quizBrainMulti.getQuestionAnswer() == 0
                    ? Colors.green
                    : (isAnswered && quizBrainMulti.getQuestionAnswer() != 0 ? Colors.red : Colors.white),
              ),
              MultipleButton(
                title: quizBrainMulti.getOptions().elementAt(1),
                onPressed: isAnswered ? (){} : () => checkAnswer(1),
                backgroundColor: answerSelected && quizBrainMulti.getQuestionAnswer() == 1
                    ? Colors.green
                    : (isAnswered && quizBrainMulti.getQuestionAnswer() != 1 ? Colors.red : Colors.white),
              ),
              MultipleButton(
                title: quizBrainMulti.getOptions().elementAt(2),
                onPressed: isAnswered ? (){} : () => checkAnswer(2),
                backgroundColor: answerSelected && quizBrainMulti.getQuestionAnswer() == 2
                    ? Colors.green
                    : (isAnswered && quizBrainMulti.getQuestionAnswer() != 2 ? Colors.red : Colors.white),
              ),
              Wrap(children: scoreKeeper,),
              const SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
