import 'package:bharatnxt/features/chat/domain/entities/chat_message.dart';

class ChatSession {
  final String id;
  final String title;
  final DateTime createdAt;
  final List<ChatMessage> messages;

  const ChatSession({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.messages,
  });

  ChatMessage? get lastMessage => messages.isEmpty ? null : messages.last;

  ChatSession copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    List<ChatMessage>? messages,
  }) =>
      ChatSession(
        id: id ?? this.id,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        messages: messages ?? this.messages,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'createdAt': createdAt.toIso8601String(),
        'messages': messages.map((m) => m.toMap()).toList(),
      };

  factory ChatSession.fromMap(Map<dynamic, dynamic> map) => ChatSession(
        id: map['id'] as String,
        title: map['title'] as String,
        createdAt: DateTime.parse(map['createdAt'] as String),
        messages: (map['messages'] as List<dynamic>)
            .map((e) => ChatMessage.fromMap(e as Map<dynamic, dynamic>))
            .toList(),
      );
}
