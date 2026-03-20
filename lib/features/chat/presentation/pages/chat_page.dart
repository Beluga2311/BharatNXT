import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bharatnxt/core/di/injector.dart';
import 'package:bharatnxt/core/local/local_storage_service.dart';
import 'package:bharatnxt/core/widgets/theme_toggle_button.dart';
import 'package:bharatnxt/features/chat/data/datasources/chat_local_datasource.dart';
import 'package:bharatnxt/features/chat/data/datasources/chat_mock_datasource.dart';
import 'package:bharatnxt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:bharatnxt/features/chat/presentation/pages/chat_session_page.dart';
import 'package:bharatnxt/features/chat/presentation/widgets/chat_list_tile.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBloc>(
      create: (_) => ChatBloc(
        local: ChatLocalDataSource(sl<LocalStorageService>()),
        mock: ChatMockDataSource(),
      )..add(const LoadChatSessionsEvent()),
      child: const _ChatPageContent(),
    );
  }
}

class _ChatPageContent extends StatelessWidget {
  const _ChatPageContent();

  void _openSession(BuildContext context, String sessionId) {
    context.read<ChatBloc>().add(OpenChatSessionEvent(sessionId));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ChatBloc>(),
          child: const ChatSessionPage(),
        ),
      ),
    );
  }

  void _createNewChat(BuildContext context) {
    context.read<ChatBloc>().add(const CreateNewChatSessionEvent());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ChatBloc>(),
          child: const ChatSessionPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.inversePrimary,
        title: const Text('Chats'),
        actions: const [ThemeToggleButton()],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatErrorState) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(color: cs.error),
              ),
            );
          }

          if (state is ChatSessionsLoadedState) {
            if (state.sessions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat_bubble_outline_rounded,
                        size: 72, color: cs.outlineVariant),
                    const SizedBox(height: 16),
                    Text(
                      'No chats yet',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap + to start a new conversation',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: cs.outlineVariant),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              itemCount: state.sessions.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                indent: 72,
                color: cs.outlineVariant,
              ),
              itemBuilder: (context, i) {
                final session = state.sessions[i];
                return ChatListTile(
                  session: session,
                  onTap: () => _openSession(context, session.id),
                  onDelete: () => context
                      .read<ChatBloc>()
                      .add(DeleteChatSessionEvent(session.id)),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewChat(context),
        icon: const Icon(Icons.add_comment_rounded),
        label: const Text('New Chat'),
      ),
    );
  }
}
