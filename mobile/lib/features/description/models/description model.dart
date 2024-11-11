class DescriptionModel {
  final String message;
  final String author;
  final String historicalPeriod;
  final String colorComposition;
  final String style;

  DescriptionModel({
    required this.message,
    required this.author,
    required this.historicalPeriod,
    required this.colorComposition,
    required this.style,
  });

  factory DescriptionModel.fromJson(Map<String, dynamic> json) {
    final message = json['message'] as String;

    // Extract sections from the message
    final authorSection = _extractSection(message, 'Author:');
    final historicalPeriodSection = _extractSection(message, 'Historical Period:');
    final colorCompositionSection = _extractSection(message, 'Color Composition:');
    final styleSection = _extractSection(message, 'Style:');

    return DescriptionModel(
      message: message,
      author: authorSection,
      historicalPeriod: historicalPeriodSection,
      colorComposition: colorCompositionSection,
      style: styleSection,
    );
  }

  static String _extractSection(String text, String sectionTitle) {
    final startIndex = text.indexOf(sectionTitle);
    if (startIndex == -1) return '';

    final endIndex = text.indexOf('\n\n', startIndex);
    if (endIndex == -1) return text.substring(startIndex + sectionTitle.length).trim();

    return text.substring(startIndex + sectionTitle.length, endIndex).trim();
  }

  @override
  String toString() {
    return 'DescriptionModel{\n'
        'message: $message\n'
        'author: $author\n'
        'historicalPeriod: $historicalPeriod\n'
        'colorComposition: $colorComposition\n'
        'style: $style\n'
        '}';
  }
}