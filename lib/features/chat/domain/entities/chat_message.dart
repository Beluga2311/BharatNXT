enum ChatSender { user, assistant }

class ChatMessage {
  final String id;
  final ChatSender sender;
  final String text;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'sender': sender.name,
        'text': text,
        'timestamp': timestamp.toIso8601String(),
      };

  factory ChatMessage.fromMap(Map<dynamic, dynamic> map) => ChatMessage(
        id: map['id'] as String,
        sender: ChatSender.values.byName(map['sender'] as String),
        text: map['text'] as String,
        timestamp: DateTime.parse(map['timestamp'] as String),
      );
}
