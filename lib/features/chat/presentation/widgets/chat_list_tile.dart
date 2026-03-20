import 'package:flutter/material.dart';
import 'package:bharatnxt/features/chat/domain/entities/chat_message.dart';
import 'package:bharatnxt/features/chat/domain/entities/chat_session.dart';

class ChatListTile extends StatelessWidget {
  final ChatSession session;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ChatListTile({
    super.key,
    required this.session,
    required this.onTap,
    required this.onDelete,
  });

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${dt.day}/${dt.month}/${dt.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final last = session.lastMessage;

    final preview = last == null
        ? 'No messages yet'
        : (last.sender == ChatSender.user ? 'You: ' : '') + last.text;

    return Dismissible(
      key: ValueKey(session.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: cs.errorContainer,
        child: Icon(Icons.delete_rounded, color: cs.onErrorContainer),
      ),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: cs.primaryContainer,
          child: Icon(Icons.chat_bubble_rounded,
              color: cs.onPrimaryContainer, size: 20),
        ),
        title: Text(
          session.title,
          style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w600),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          preview,
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: last == null
            ? null
            : Text(
                _formatTime(last.timestamp),
                style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              ),
      ),
    );
  }
}
