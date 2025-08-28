class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime createdAt;
  final bool isRead;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.createdAt,
    required this.isRead,
  });

  factory Message.fromJson(Map<String, dynamic> j) => Message(
        id: j['id'],
        conversationId: j['conversation_id'],
        senderId: j['sender_id'],
        receiverId: j['receiver_id'],
        content: j['content'] ?? '',
        createdAt: DateTime.parse(j['created_at']),
        isRead: j['is_read'] ?? false,
      );
}
