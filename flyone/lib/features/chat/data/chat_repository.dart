import '../../../core/utils/result.dart';
import '../domain/models/chat_message.dart';

abstract class ChatRepository {
  Future<Result<ChatMessage>> sendMessage(String message);
}
