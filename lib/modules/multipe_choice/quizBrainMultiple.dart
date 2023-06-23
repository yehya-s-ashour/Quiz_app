import 'package:multi_quiz_s_t_tt9/modules/multipe_choice/questionMultiple.dart';

class QuizBrainMulti {
  int questionNumber = 0;

  final List<QuestionMultiple> _questionBank = [
    QuestionMultiple('You can lead a cow down stairs but not up stairs.', 1,
        ['always', 'never', 'sometimes']),
    QuestionMultiple(
        'Approximately one quarter of human bones are in the feet.',
        0,
        ['agree', 'disagree', 'not sure']),
  ];

  bool isFinished() {
    if (questionNumber == _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }


  String getQuestionText() {
    return _questionBank[questionNumber].questionText;
  }

  int getQuestionAnswer() {
    return _questionBank[questionNumber].questionAnswer;
  }
int getLength(){
    return _questionBank.length;
}


  List<String> getOptions() {
    return _questionBank[questionNumber].options;
  }

  void nextQuestion() {
    if (questionNumber < _questionBank.length - 1) {
      questionNumber++;
    }
  }

  void reset() {
    questionNumber = 0;
  }
}
