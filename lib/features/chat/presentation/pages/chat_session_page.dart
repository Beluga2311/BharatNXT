import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bharatnxt/core/widgets/theme_toggle_button.dart';
import 'package:bharatnxt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:bharatnxt/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:bharatnxt/features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:bharatnxt/features/chat/presentation/widgets/typing_indicator.dart';

class ChatSessionPage extends StatefulWidget {
  const ChatSessionPage({super.key});

  @override
  State<ChatSessionPage> createState() => _ChatSessionPageState();
}

class _ChatSessionPageState extends State<ChatSessionPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          context.read<ChatBloc>().add(const LoadChatSessionsEvent());
        }
      },
      child: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatSessionViewState) _scrollToBottom();
        },
        builder: (context, state) {
          final String title;
          final Widget body;

          if (state is ChatLoadingState || state is ChatInitialState) {
            title = 'Loading…';
            body = const Center(child: CircularProgressIndicator());
          } else if (state is ChatErrorState) {
            title = 'Error';
            body = Center(
              child: Text(
                state.message,
                style: TextStyle(color: cs.error),
              ),
            );
          } else if (state is ChatSessionViewState) {
            title = state.session.title;
            body = Column(
              children: [
                Expanded(
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          itemCount: state.session.messages.length +
                              (state.isSending ? 1 : 0),
                          itemBuilder: (context, i) {
                            if (state.isSending &&
                                i == state.session.messages.length) {
                              return const TypingIndicator();
                            }
                            return ChatBubble(
                                message: state.session.messages[i]);
                          },
                        ),
                ),
                ChatInputBar(
                  enabled: !state.isSending && !state.isLoading,
                  onSend: (text) =>
                      context.read<ChatBloc>().add(SendMessageEvent(text)),
                ),
              ],
            );
          } else {
            title = '';
            body = const SizedBox.shrink();
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: cs.inversePrimary,
              title: Text(title),
              actions: const [ThemeToggleButton()],
            ),
            body: body,
          );
        },
      ),
    );
  }
}
