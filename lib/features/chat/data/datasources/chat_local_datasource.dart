import 'package:bharatnxt/core/local/hive_service.dart';
import 'package:bharatnxt/core/local/local_storage_service.dart';
import 'package:bharatnxt/features/chat/domain/entities/chat_session.dart';

class ChatLocalDataSource {
  final LocalStorageService _storage;

  ChatLocalDataSource(this._storage);

  List<ChatSession> getAllSessions() {
    return _storage
        .getAll(HiveService.chatsBox)
        .map((e) => ChatSession.fromMap(e as Map<dynamic, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  ChatSession? getSession(String id) {
    final raw = _storage.get(HiveService.chatsBox, id);
    if (raw == null) return null;
    return ChatSession.fromMap(raw as Map<dynamic, dynamic>);
  }

  Future<void> saveSession(ChatSession session) async {
    await _storage.put(HiveService.chatsBox, session.id, session.toMap());
  }

  Future<void> deleteSession(String id) async {
    await _storage.delete(HiveService.chatsBox, id);
  }

  int get sessionCount => _storage.count(HiveService.chatsBox);
}
