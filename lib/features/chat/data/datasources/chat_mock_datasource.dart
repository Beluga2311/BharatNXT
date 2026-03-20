import 'package:bharatnxt/features/chat/domain/entities/chat_message.dart';

class ChatMockDataSource {
  static int _idCounter = 0;

  String _newId() =>
      '${DateTime.now().millisecondsSinceEpoch}_${_idCounter++}';

  DateTime _ago(int minutes) =>
      DateTime.now().subtract(Duration(minutes: minutes));

  Future<List<ChatMessage>> getInitialMessages() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      ChatMessage(
        id: _newId(),
        sender: ChatSender.user,
        text: 'Hi, I need help finding bulk electronic components.',
        timestamp: _ago(12),
      ),
      ChatMessage(
        id: _newId(),
        sender: ChatSender.assistant,
        text:
            'Hello! Welcome to BharatNxt. I can help you source components in bulk. What type are you looking for — capacitors, resistors, ICs, or something else?',
        timestamp: _ago(11),
      ),
      ChatMessage(
        id: _newId(),
        sender: ChatSender.user,
        text: 'I need capacitors — around 10,000 units.',
        timestamp: _ago(10),
      ),
      ChatMessage(
        id: _newId(),
        sender: ChatSender.assistant,
        text:
            'Got it! To find the best suppliers for 10,000 capacitors, could you share: (1) capacitance value & voltage rating, (2) target price per unit, and (3) preferred delivery timeline?',
        timestamp: _ago(9),
      ),
    ];
  }

  Future<String> getMockReply(String userMessage) async {
    await Future.delayed(const Duration(milliseconds: 1200));

    final lower = userMessage.toLowerCase();

    if (lower.contains('price') || lower.contains('cost')) {
      return 'Pricing depends on the quantity and specifications. For orders above 5,000 units, you can typically negotiate a 10–15% discount. Want me to connect you with verified suppliers?';
    } else if (lower.contains('deliver') || lower.contains('ship')) {
      return 'Standard delivery takes 5–7 business days within India. Express shipping (2–3 days) is available for an additional charge. Which city are you shipping to?';
    } else if (lower.contains('quality') || lower.contains('certif')) {
      return 'All listed suppliers on BharatNxt are verified and meet ISI/ISO standards. You can also request sample batches before placing bulk orders.';
    } else if (lower.contains('payment') || lower.contains('pay')) {
      return 'We support Net 30/60 payment terms for verified buyers. You can also use our escrow service for added security on large orders.';
    } else {
      return 'Thanks for your message! I\'m looking into that for you. Our team will also follow up within 24 hours if you need specialist assistance.';
    }
  }
}
