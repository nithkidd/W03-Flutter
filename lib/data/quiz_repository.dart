import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final data = jsonDecode(content); //convert text to map

    // Map JSON to domain objects
    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
        id: q['id'],  
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        points: q['points'],
      );
    }).toList();

    return Quiz(
      id: data['id'], 
      questions: questions
    );
  }
  Quiz writeQuiz(Quiz quiz) {
    final file = File(filePath);

    // Map domain objects to JSON
    final data = {
      'id': quiz.id,
      'questions': quiz.questions.map((q) => {
            'id': q.id,
            'title': q.title,
            'choices': q.choices,
            'goodChoice': q.goodChoice,
            'points': q.points,
          }).toList(),
    };

    final content = jsonEncode(data);
    file.writeAsStringSync(content);

    return quiz;
  }
}
