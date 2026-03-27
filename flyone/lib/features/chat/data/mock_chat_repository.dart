import '../../../core/utils/result.dart';
import '../domain/models/chat_message.dart';
import 'chat_repository.dart';

class MockChatRepository implements ChatRepository {
  // Response data map — messages are constructed fresh at send time to get accurate timestamps
  static const _responseData = {
    'default': (
      id: 'ai-1',
      text: 'I can help you find the best travel options! Try asking me about flights, trains, or destinations.',
      quickReplies: ['Find flights to Bali', 'Train to Bandung', 'Best deals this week'],
    ),
    'bali': (
      id: 'ai-2',
      text: 'Great choice! I found 12 flights to Bali starting from \$120. The cheapest option is Lion Air departing at 14:30. Would you like me to search for specific dates?',
      quickReplies: ['Show cheapest', 'This weekend', 'Next month'],
    ),
    'bandung': (
      id: 'ai-3',
      text: 'For Jakarta to Bandung, I recommend Whoosh high-speed train — it takes only 45 minutes! Prices start at \$15. The next departure is at 10:00.',
      quickReplies: ['Book now', 'Show all options', 'Different date'],
    ),
    'deals': (
      id: 'ai-4',
      text: 'Here are this week\'s best deals:\n\n🔥 Jakarta→Bali from \$89 (40% off)\n🔥 Jakarta→Singapore from \$120\n🔥 Weekend getaway packages from \$45\n\nWant me to book any of these?',
      quickReplies: ['Book Bali deal', 'More deals', 'Set price alert'],
    ),
  };

  @override
  Future<Result<ChatMessage>> sendMessage(String message) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final lower = message.toLowerCase();

    final ({String id, String text, List<String> quickReplies}) data;
    if (lower.contains('bali')) {
      data = _responseData['bali']!;
    } else if (lower.contains('bandung') || lower.contains('train')) {
      data = _responseData['bandung']!;
    } else if (lower.contains('deal') || lower.contains('cheap') || lower.contains('best')) {
      data = _responseData['deals']!;
    } else {
      data = _responseData['default']!;
    }

    return Success(ChatMessage(
      id: data.id,
      text: data.text,
      isUser: false,
      timestamp: DateTime.now(),
      quickReplies: data.quickReplies,
    ));
  }
}
