import 'dart:io';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;
  Map<String, Player> players = {};

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    while (true) {
      stdout.write('Your name: ');
      String? playerName = stdin.readLineSync();
      playerName = playerName ?? '';

      if (playerName.isEmpty) {
        if (players.isNotEmpty) {
          players.forEach((name, player) {
            print('Player: $name\t\tScore:${player.scoreInPoints}');
          });
        }
        print('--- Quiz Finished ---');
        break;
      }

      for (var question in quiz.questions) {
        print('Question: ${question.title} - (${question.points} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer =
              Answer(questionId: question.id, answerChoice: userInput);
          quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      // Calculate scores
      int score = quiz.getScoreInPercentage();
      int points = quiz.getScoreInPoints();

      Player player = Player(
        name: playerName,
        scoreInPercentage: score,
        scoreInPoints: points,
      );
      players[playerName] = player;
      print('${player.name}, your score in percentage: $score %');
      print('${player.name}, your score in points: $points points');

      players.forEach((name, player) {
        print('Player: $name\t\tScore:${player.scoreInPoints}');
      });
      quiz.resetAnswers();
      print('');
    }
  }
}
