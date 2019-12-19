import 'package:equatable/equatable.dart';

class TodoItem extends Equatable {
  final int id;
  final String topic;
  final String content;
  final DateTime date;

  TodoItem({this.id, this.topic, this.content, this.date});

  factory TodoItem.fromJson(Map<String, dynamic> json) {
    return TodoItem(
      id: int.parse(json['id'].toString()),
      topic: json['topic'],
      content: json['content'],
      date:
          json['date'] == null ? DateTime.now() : DateTime.parse(json['date']),
    );
  }

  @override
  List<Object> get props => [
        id,
        topic,
        content,
        date,
      ];
}
