import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/Helpers.dart';
import 'package:multi_quiz_s_t_tt9/constants.dart';
import 'package:multi_quiz_s_t_tt9/modules/multipe_choice/quizBrainMultiple.dart';
import 'package:multi_quiz_s_t_tt9/pages/home.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

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
  Color answerColor1 = Colors.white;
  Color answerfontColor1 = Colors.black;
  Color answerColor2 = Colors.white;
  Color answerfontColor2 = Colors.black;
  Color answerColor3 = Colors.white;
  Color answerfontColor3 = Colors.black;
  bool isAnswered = false;

  late Timer _timer;

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
      isAnswered = true;
      if (isCorrect) {
        scoreKeeper.add(
          const Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });

    setState(() {
      isAnswered = false;
    });
    if (isCorrect) {
      goToNextQuestion();
    } else {
      goToNextQuestion();
      //counter = 10;
    }
  }

  void goToNextQuestion() {
    if (quizBrainMulti.isFinished()) {
      _timer.cancel();
      showQuizFinishedDialog(
          context, score, counter, quizBrainMulti.getLength());
    } else {
      setState(() {
        counter = 10;
        questionNumber++;
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
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/ballon-b.png'),
                ),
              ),
              SizedBox(
                height: 20,
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
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontFamily: 'Sf-Pro-Text',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: isAnswered
                      ? null
                      : () {
                          if (quizBrainMulti.getQuestionAnswer() == 0) {
                            score++;
                            answerfontColor1 = Colors.white;
                            answerColor1 = Colors.green;
                          } else {
                            answerfontColor1 = Colors.white;

                            answerColor1 = Colors.red;
                          }

                          setState(() {
                            counter = 10;
                          });
                          Timer(Duration(milliseconds: 500), () {
                            setState(() {
                              isAnswered = true;
                              checkAnswer(0);
                              answerColor1 = Colors.white;
                              answerfontColor1 = Colors.black;
                            });
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: answerColor1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            quizBrainMulti.getOptions().elementAt(0),
                            style: TextStyle(
                                color: answerfontColor1,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: isAnswered
                      ? null
                      : () {
                          if (quizBrainMulti.getQuestionAnswer() == 1) {
                            score++;
                            answerfontColor2 = Colors.white;
                            answerColor2 = Colors.green;
                          } else {
                            answerfontColor2 = Colors.white;

                            answerColor2 = Colors.red;
                          }

                          setState(() {
                            counter = 10;
                          });
                          Timer(Duration(milliseconds: 500), () {
                            setState(() {
                              isAnswered = true;
                              checkAnswer(1);
                              answerColor2 = Colors.white;
                              answerfontColor2 = Colors.black;
                            });
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: answerColor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            quizBrainMulti.getOptions().elementAt(1),
                            style: TextStyle(
                                color: answerfontColor2,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: isAnswered
                      ? null
                      : () {
                          if (quizBrainMulti.getQuestionAnswer() == 2) {
                            score++;
                            answerfontColor3 = Colors.white;
                            answerColor3 = Colors.green;
                          } else {
                            answerfontColor3 = Colors.white;

                            answerColor3 = Colors.red;
                          }

                          setState(() {
                            counter = 10;
                          });
                          Timer(Duration(milliseconds: 500), () {
                            setState(() {
                              isAnswered = true;
                              checkAnswer(2);
                              answerColor3 = Colors.white;
                              answerfontColor3 = Colors.black;
                            });
                          });
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: answerColor3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            quizBrainMulti.getOptions().elementAt(2),
                            style: TextStyle(
                                color: answerfontColor3,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Wrap(
                children: scoreKeeper,
              ),
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
