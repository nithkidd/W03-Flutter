import 'package:uuid/uuid.dart';

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  int points = 1;

  Question(
      {String? id,
      required this.title,
      required this.choices,
      required this.goodChoice,
      this.points = 1})
      : id = id ?? const Uuid().v4();
}

class Answer {
  final String id;
  final String questionId;
  final String answerChoice;

  Answer({String? id, required this.questionId, required this.answerChoice})
      : id = id ?? const Uuid().v4();

  bool isGood(Quiz quiz) {
    Question question = quiz.getQuestionById(questionId);
    return this.answerChoice == question.goodChoice;
  }
}

class Quiz {
  final String id;
  List<Question> questions;
  List<Answer> answers = [];

  Quiz({String? id, required this.questions}) : id = id ?? const Uuid().v4();

  void addAnswer(Answer answer) {
    this.answers.add(answer);
  }

  void resetAnswers() {
    answers.clear();
  }

  Question getQuestionById(String questionId) {
    return questions.firstWhere((q) => q.id == questionId);
  }

  Answer getAnswerById(String answerId) {
    return answers.firstWhere((a) => a.id == answerId);
  }

  int getScoreInPercentage() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood(this)) {
        totalSCore++;
      }
    }
    return ((totalSCore / questions.length) * 100).toInt();
  }

  int getScoreInPoints() {
    int totalPoints = 0;
    for (Answer answer in answers) {
      if (answer.isGood(this)) {
        Question question = getQuestionById(answer.questionId);
        totalPoints += question.points;
      }
    }
    return totalPoints;
  }
}

class Submission {
  final String id;
  final String quizId;
  final List<Answer> answers;

  Submission({
    String? id,
    required this.quizId,
    List<Answer>? answers,
  })  : id = id ?? const Uuid().v4(),
        answers = answers ?? [];

  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  int getScore(Quiz quiz) {
    int totalScore = 0;
    for (Answer answer in answers) {
      if (answer.isGood(quiz)) {
        totalScore++;
      }
    }
    return totalScore;
  }

  int getScoreInPercentage(Quiz quiz) {
    if (quiz.questions.isEmpty) return 0;
    return ((getScore(quiz) / quiz.questions.length) * 100).toInt();
  }

  int getScoreInPoints(Quiz quiz) {
    int totalPoints = 0;
    for (Answer answer in answers) {
      if (answer.isGood(quiz)) {
        Question question = quiz.getQuestionById(answer.questionId);
        totalPoints += question.points;
      }
    }
    return totalPoints;
  }
}

class Player {
  final String name;
  int scoreInPercentage;
  int scoreInPoints;

  Player(
      {required this.name,
      required this.scoreInPercentage,
      required this.scoreInPoints});
}
