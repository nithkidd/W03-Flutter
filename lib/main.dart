import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quiz_repository.dart';

void main() {
  QuizRepository repository = QuizRepository('lib/data/quiz_data.json');

  Quiz quiz = repository.readQuiz();

  quiz.questions.add(Question(
    title: 'What animal has 4 legs?',
    choices: ['Dog', 'Snake', 'Human'],
    goodChoice: 'Dog',
    points: 10,
  ));
  quiz.questions.add(Question(
    title: 'first alphabet?',
    choices: ['A', 'B', 'C'],
    goodChoice: 'A',
    points: 30,
  ));

  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();
}
