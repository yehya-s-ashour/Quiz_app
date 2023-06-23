import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/Helpers.dart';
import 'package:multi_quiz_s_t_tt9/widgets/multiple_button.dart';

import '../constants.dart';
import '../widgets/quiz_app_bar_row.dart';
import 'home.dart';

class TrueFalseQuiz extends StatefulWidget {
  const TrueFalseQuiz({super.key});

  @override
  _TrueFalseQuizState createState() => _TrueFalseQuizState();
}

class _TrueFalseQuizState extends State<TrueFalseQuiz> with Helpers{


  List<Icon> scoreKeeper = [];

  int counter = 10;
  int score = 0;
  bool? correctAnswer ;
int questionNumber = 1 ;
  bool isAnswered = false;
  bool answerSelected = false;

  late Timer _timer ;
  void checkAnswer(bool userChoice) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
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
    if (quizBrain.isFinished()) {
      _timer.cancel();
      // From Helpers mixin
      showQuizFinishedDialog(context,score,counter,quizBrain.getSizeQuestions());
    } else {
      setState(() {
        counter = 10;
        questionNumber++;
        answerSelected = false;
        quizBrain.nextQuestion();
      });
    }
  }



  @override
  void initState() {
   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
setState(() {
  if(counter>0){
    counter--;
  }

});


      if (counter == 0) {
        // timer.cancel();
        setState(() {

            scoreKeeper.add(
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
            );


        });

        counter = 10;
        quizBrain.nextQuestion();
      //  checkAnswerColor = Colors.black38;
      }

    });
    super.initState();
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
        decoration:const BoxDecoration(
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
              QuizAppBarRow(counter: counter,
              pageNameWidget: const HomePage(),
              ),
              Expanded(
                flex: 5,
                child: Padding(
                  padding:const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      quizBrain.getQuestionText(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:const EdgeInsets.all(15.0),
                  child: MultipleButton(
                    onPressed: (){
                      //The user picked true.
                      checkAnswer(true);
                      setState(() {
                        counter = 10;
                      });
                    },
                    title: 'True',
                    backgroundColor: answerSelected && quizBrain.getQuestionAnswer() == true
                        ? Colors.green
                        : (isAnswered && quizBrain.getQuestionAnswer() != true ? Colors.red : Colors.white),

                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:const EdgeInsets.all(15.0),
                  child: MultipleButton(

                    onPressed: (){
                      //The user picked true.
                      checkAnswer(false);
                      setState(() {
                        counter = 10;
                      });
                    },
                    title: 'False',
                    backgroundColor: answerSelected && quizBrain.getQuestionAnswer() == false
                        ? Colors.green
                        : (isAnswered && quizBrain.getQuestionAnswer() != false ? Colors.red : Colors.white),

                  ),
                ),
              ),
              Wrap(
                children: scoreKeeper,
              ),
              const SizedBox(
                height: 72,
              )
            ],
          ),
        ),
      ),
    );
  }
}

