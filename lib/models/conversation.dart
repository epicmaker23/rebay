import 'ad.dart';
import 'user.dart';
import 'message.dart';

class Conversation {
  final String id;
  final Ad ad;
  final User otherUser;
  final Message? lastMessage;
  final DateTime lastMessageAt;
  final int unreadCount;

  Conversation({
    required this.id,
    required this.ad,
    required this.otherUser,
    this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
  });

  factory Conversation.fromJson(Map<String, dynamic> j) => Conversation(
        id: j['id'],
        ad: Ad.fromJson(j['ad']),
        otherUser: User.fromJson(j['other_user']),
        lastMessage: j['last_message'] != null ? Message.fromJson(j['last_message']) : null,
        lastMessageAt: DateTime.parse(j['last_message_at']),
        unreadCount: j['unread_count'] ?? 0,
      );
}
