import 'dart:async';

import 'package:flutter/material.dart';

import '../Helpers.dart';
import '../constants.dart';
import '../modules/true_false/quizBrain.dart';
import '../widgets/my_outline_btn.dart';
import 'home.dart';

class TrueFalseQuiz extends StatefulWidget {
  @override
  _TrueFalseQuizState createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> with Helpers {
  QuizBrain quizBrain = QuizBrain();

  List<Icon> scoreKeeper = [];
  bool anwerChoosen = false;
  int? _choice;
  Color answerColor1 = Colors.white;
  Color answerfontColor1 = Colors.black;
  Color answerColor2 = Colors.white;
  Color answerfontColor2 = Colors.black;
  int counter = 10;
  late Timer _timer;
  int score = 0;

  void checkAnswer(bool userChoice) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (correctAnswer == userChoice) {
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

    goToNextQuestion();
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        counter--;
      });
      if (counter == 0) {
        // timer.cancel();
        counter = 10;
        //quizBrain.nextQuestion();
        goToNextQuestion();
      }
    });
    super.initState();
  }

  void goToNextQuestion() {
    if (quizBrain.isFinished()) {
      counter = 0;
      _timer.cancel();
      // From Helpers mixin
      showQuizFinishedDialog(
          context, score, counter, quizBrain.getSizeQuestions());
    } else {
      setState(() {
        counter = 10;
        //questionNumber++;
        anwerChoosen = false;
        quizBrain.nextQuestion();
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(top: 74, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                        // Navigator.pop(context);
                        // Navigator.pop(context);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                  counter != 0
                      ? Stack(
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
                              style: TextStyle(
                                fontFamily: 'Sf-Pro-Text',
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      : const SizedBox(
                          child: Text(
                            'Finished',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0),
                          ),
                        ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: BorderSide(color: Colors.white)),
                  ),
                ],
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(answerColor1),
                    ),
                    child: Text(
                      'True',
                      style: TextStyle(
                        color: answerfontColor1,
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: anwerChoosen
                        ? null
                        : () {
                            if (quizBrain.getQuestionAnswer() == true) {
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
                            Timer(Duration(seconds: 1), () {
                              setState(() {
                                anwerChoosen = true;
                                checkAnswer(true);
                                answerColor1 = Colors.white;
                                answerfontColor1 = Colors.black;
                              });
                            });
                          },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ButtonStyle().copyWith(
                      backgroundColor: MaterialStatePropertyAll(answerColor2),
                    ),
                    child: Text(
                      'False',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: answerfontColor2,
                      ),
                    ),
                    onPressed: anwerChoosen
                        ? null
                        : () {
                            print(score);

                            if (quizBrain.getQuestionAnswer() == false) {
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
                            Timer(Duration(seconds: 1), () {
                              setState(() {
                                anwerChoosen = true;
                                checkAnswer(false);
                                answerColor2 = Colors.white;
                                answerfontColor2 = Colors.black;
                              });
                            });
                          },
                  ),
                ),
              ),
              // Wrap(
              //   children: scoreKeeper,
              // ),
              SizedBox(
                height: 72,
              )
            ],
          ),
        ),
      ),
    );
  }
}
