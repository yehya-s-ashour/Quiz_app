import 'dart:async';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../modules/true_false/quizBrain.dart';
import '../widgets/my_outline_btn.dart';
import 'home.dart';

class TrueFalseQuiz extends StatefulWidget {
  @override
  _TrueFalseQuizState createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> {
  QuizBrain quizBrain = QuizBrain();

  List<Icon> scoreKeeper = [];
  bool anwerChoosen = false;
  int? _choice;
  Color answerColor1 = Colors.white;
  Color answerfontColor1 = Colors.black;
  Color answerColor2 = Colors.white;
  Color answerfontColor2 = Colors.black;
  int counter = 10;

  int score = 0;

  void checkAnswer(bool userChoice) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (correctAnswer == userChoice) {
        scoreKeeper.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        scoreKeeper.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });

    void showQuizFinishedDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Quiz Finished'),
            content: Text(
              'Congratulations! You have completed the quiz. $score / ${quizBrain.getSizeQuestions()}',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }

    if (quizBrain.isFinished()) {
      showQuizFinishedDialog(context);

      Timer(Duration(seconds: 1), () {
        // Alert(context: context, title: "Finished", desc: "you are done").show();
        setState(() {
          quizBrain.reset();
          scoreKeeper.clear();
          score = 0;
        });
      });
    } else {
      anwerChoosen = false;
      quizBrain.nextQuestion();
    }
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        counter--;
      });
      if (counter == 0) {
        // timer.cancel();
        counter = 10;
        quizBrain.nextQuestion();
      }
      ;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
                        style: TextStyle(
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
                            Timer(Duration(milliseconds: 500), () {
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
                            Timer(Duration(milliseconds: 500), () {
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
              Wrap(
                children: scoreKeeper,
              ),
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
