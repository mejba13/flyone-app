import '../../../core/utils/result.dart';
import '../domain/models/chat_message.dart';
import 'chat_repository.dart';

class MockChatRepository implements ChatRepository {
  final _responses = {
    'default': ChatMessage(
      id: 'ai-1',
      text: 'I can help you find the best travel options! Try asking me about flights, trains, or destinations.',
      isUser: false,
      timestamp: DateTime.now(),
      quickReplies: ['Find flights to Bali', 'Train to Bandung', 'Best deals this week'],
    ),
    'bali': ChatMessage(
      id: 'ai-2',
      text: 'Great choice! I found 12 flights to Bali starting from \$120. The cheapest option is Lion Air departing at 14:30. Would you like me to search for specific dates?',
      isUser: false,
      timestamp: DateTime.now(),
      quickReplies: ['Show cheapest', 'This weekend', 'Next month'],
    ),
    'bandung': ChatMessage(
      id: 'ai-3',
      text: 'For Jakarta to Bandung, I recommend Whoosh high-speed train — it takes only 45 minutes! Prices start at \$15. The next departure is at 10:00.',
      isUser: false,
      timestamp: DateTime.now(),
      quickReplies: ['Book now', 'Show all options', 'Different date'],
    ),
    'deals': ChatMessage(
      id: 'ai-4',
      text: 'Here are this week\'s best deals:\n\n🔥 Jakarta→Bali from \$89 (40% off)\n🔥 Jakarta→Singapore from \$120\n🔥 Weekend getaway packages from \$45\n\nWant me to book any of these?',
      isUser: false,
      timestamp: DateTime.now(),
      quickReplies: ['Book Bali deal', 'More deals', 'Set price alert'],
    ),
  };

  @override
  Future<Result<ChatMessage>> sendMessage(String message) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final lower = message.toLowerCase();
    if (lower.contains('bali')) return Success(_responses['bali']!);
    if (lower.contains('bandung') || lower.contains('train')) return Success(_responses['bandung']!);
    if (lower.contains('deal') || lower.contains('cheap') || lower.contains('best')) {
      return Success(_responses['deals']!);
    }
    return Success(_responses['default']!);
  }
}
