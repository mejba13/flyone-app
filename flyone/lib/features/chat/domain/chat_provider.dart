import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/result.dart';
import '../data/chat_repository.dart';
import '../data/mock_chat_repository.dart';
import 'models/chat_message.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) => MockChatRepository());

final chatMessagesProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(ref.read(chatRepositoryProvider)),
);

final isTypingProvider = StateProvider<bool>((ref) => false);

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final ChatRepository _repo;

  ChatNotifier(this._repo)
      : super([
          ChatMessage(
            id: 'welcome',
            text: 'Hi! I\'m your AI travel assistant. How can I help you today? ✈️',
            isUser: false,
            timestamp: DateTime.now(),
            quickReplies: ['Find flights to Bali', 'Train to Bandung', 'Best deals this week'],
          ),
        ]);

  Future<void> send(String message, StateController<bool> typingController) async {
    state = [
      ...state,
      ChatMessage(
        id: 'user-${state.length}',
        text: message,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    ];
    typingController.state = true;
    final result = await _repo.sendMessage(message);
    typingController.state = false;
    if (result case Success(:final data)) {
      state = [...state, data];
    }
  }
}
