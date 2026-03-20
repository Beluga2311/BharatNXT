part of 'chat_bloc.dart';

sealed class ChatEvent {
  const ChatEvent();
}

final class LoadChatSessionsEvent extends ChatEvent {
  const LoadChatSessionsEvent();
}

final class CreateNewChatSessionEvent extends ChatEvent {
  const CreateNewChatSessionEvent();
}

final class OpenChatSessionEvent extends ChatEvent {
  final String sessionId;
  const OpenChatSessionEvent(this.sessionId);
}

final class SendMessageEvent extends ChatEvent {
  final String message;
  const SendMessageEvent(this.message);
}

final class DeleteChatSessionEvent extends ChatEvent {
  final String sessionId;
  const DeleteChatSessionEvent(this.sessionId);
}
