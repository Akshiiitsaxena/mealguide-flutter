class OnboardingQuestion {
  final QuestionType type;
  final String question;
  final String key;
  final List<OnboardingOption>? options;

  OnboardingQuestion({
    required this.type,
    required this.question,
    required this.key,
    required this.options,
  });

  factory OnboardingQuestion.fromDocument(Map<String, dynamic> doc) {
    List<OnboardingOption>? options;

    if (doc.containsKey('options')) {
      options = [];
      doc['options'].forEach((optionDoc) {
        options!.add(OnboardingOption.fromDocument(optionDoc));
      });
    }

    QuestionType type;

    switch (doc['type']) {
      case 'single_choice':
        type = QuestionType.singleChoice;
        break;
      case 'multiple_choice_chips':
        type = QuestionType.multipleChoice;
        break;
      case 'age_field':
        type = QuestionType.ageField;
        break;
      case 'height_selector':
        type = QuestionType.heightSelector;
        break;
      case 'weight_selector':
        type = QuestionType.weightSelector;
        break;
      default:
        type = QuestionType.singleChoice;
    }

    return OnboardingQuestion(
      type: type,
      question: doc['question'],
      key: doc['key'],
      options: options,
    );
  }
}

class OnboardingOption {
  final String title;
  final String? subtext;

  OnboardingOption({required this.title, this.subtext});

  factory OnboardingOption.fromDocument(Map<String, dynamic> doc) {
    return OnboardingOption(title: doc['title'], subtext: doc['sub_text']);
  }
}

enum QuestionType {
  singleChoice,
  multipleChoice,
  ageField,
  heightSelector,
  weightSelector
}
