part of 'chat_bloc.dart';

sealed class ChatState {
  const ChatState();
}

final class ChatInitialState extends ChatState {
  const ChatInitialState();
}

final class ChatLoadingState extends ChatState {
  const ChatLoadingState();
}

final class ChatSessionsLoadedState extends ChatState {
  final List<ChatSession> sessions;
  const ChatSessionsLoadedState(this.sessions);
}

final class ChatSessionViewState extends ChatState {
  final ChatSession session;
  final bool isLoading;
  final bool isSending;

  const ChatSessionViewState({
    required this.session,
    this.isLoading = false,
    this.isSending = false,
  });

  ChatSessionViewState copyWith({
    ChatSession? session,
    bool? isLoading,
    bool? isSending,
  }) =>
      ChatSessionViewState(
        session: session ?? this.session,
        isLoading: isLoading ?? this.isLoading,
        isSending: isSending ?? this.isSending,
      );
}

final class ChatErrorState extends ChatState {
  final String message;
  const ChatErrorState(this.message);
}
