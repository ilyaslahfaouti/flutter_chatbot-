// model.dart

class MessageModel {
  final String content;
  final bool isUser;
  final DateTime date;

  MessageModel({required this.content, required this.isUser, required this.date});

  String toJson() {
    return '${content},${isUser},${date.toIso8601String()}';
  }

  static MessageModel fromJson(String json) {
    final parts = json.split(',');
    return MessageModel(
      content: parts[0],
      isUser: parts[1] == 'true',
      date: DateTime.parse(parts[2]),
    );
  }
}
