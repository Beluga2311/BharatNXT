import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bharatnxt/features/chat/data/datasources/chat_local_datasource.dart';
import 'package:bharatnxt/features/chat/data/datasources/chat_mock_datasource.dart';
import 'package:bharatnxt/features/chat/domain/entities/chat_message.dart';
import 'package:bharatnxt/features/chat/domain/entities/chat_session.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatLocalDataSource _local;
  final ChatMockDataSource _mock;

  ChatBloc({
    required ChatLocalDataSource local,
    required ChatMockDataSource mock,
  })  : _local = local,
        _mock = mock,
        super(const ChatInitialState()) {
    on<LoadChatSessionsEvent>(_onLoadSessions);
    on<CreateNewChatSessionEvent>(_onCreateSession);
    on<OpenChatSessionEvent>(_onOpenSession);
    on<SendMessageEvent>(_onSendMessage);
    on<DeleteChatSessionEvent>(_onDeleteSession);
  }

  Future<void> _onLoadSessions(
    LoadChatSessionsEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatLoadingState());
    final sessions = _local.getAllSessions();
    emit(ChatSessionsLoadedState(sessions));
  }

  Future<void> _onCreateSession(
    CreateNewChatSessionEvent event,
    Emitter<ChatState> emit,
  ) async {
    final id = '${DateTime.now().millisecondsSinceEpoch}';
    final count = _local.sessionCount + 1;

    final placeholder = ChatSession(
      id: id,
      title: 'Chat #$count',
      createdAt: DateTime.now(),
      messages: const [],
    );

    emit(ChatSessionViewState(session: placeholder, isLoading: true));

    final initialMessages = await _mock.getInitialMessages();

    final session = placeholder.copyWith(messages: initialMessages);
    await _local.saveSession(session);

    emit(ChatSessionViewState(session: session));
  }

  Future<void> _onOpenSession(
    OpenChatSessionEvent event,
    Emitter<ChatState> emit,
  ) async {
    final session = _local.getSession(event.sessionId);
    if (session == null) {
      emit(const ChatErrorState('Chat session not found.'));
      return;
    }
    emit(ChatSessionViewState(session: session));
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    final current = state;
    if (current is! ChatSessionViewState) return;

    final userMessage = ChatMessage(
      id: '${DateTime.now().millisecondsSinceEpoch}_u',
      sender: ChatSender.user,
      text: event.message,
      timestamp: DateTime.now(),
    );

    final sessionWithUser = current.session.copyWith(
      messages: [...current.session.messages, userMessage],
    );
    await _local.saveSession(sessionWithUser);
    emit(current.copyWith(session: sessionWithUser, isSending: true));

    final replyText = await _mock.getMockReply(event.message);

    final assistantMessage = ChatMessage(
      id: '${DateTime.now().millisecondsSinceEpoch}_a',
      sender: ChatSender.assistant,
      text: replyText,
      timestamp: DateTime.now(),
    );

    final sessionWithReply = sessionWithUser.copyWith(
      messages: [...sessionWithUser.messages, assistantMessage],
    );
    await _local.saveSession(sessionWithReply);
    emit(current.copyWith(session: sessionWithReply, isSending: false));
  }

  Future<void> _onDeleteSession(
    DeleteChatSessionEvent event,
    Emitter<ChatState> emit,
  ) async {
    await _local.deleteSession(event.sessionId);
    final sessions = _local.getAllSessions();
    emit(ChatSessionsLoadedState(sessions));
  }
}
