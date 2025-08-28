// lib/services/message_service.dart
import '../config/supabase_config.dart';
import '../models/message.dart';
import '../models/conversation.dart';

class MessageService {
  Future<List<Conversation>> getConversations() async {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return [];
    final data = await supabase.rpc(
      'get_user_conversations',
      params: {'p_user': uid},
    );
    return (data as List).map((j) => Conversation.fromJson(j)).toList();
  }

  Future<List<Message>> getMessages(String conversationId) async {
    final data = await supabase
        .from('messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true);
    return (data as List).map((j) => Message.fromJson(j)).toList();
  }

  Future<void> markMessagesAsRead(String conversationId) async {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return;
    await supabase
        .from('messages')
        .update({'is_read': true})
        .eq('conversation_id', conversationId)
        .neq('sender_id', uid);
  }

  Future<Message?> sendMessage(String conversationId, String content) async {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return null;
    final inserted = await supabase
        .from('messages')
        .insert({
          'conversation_id': conversationId,
          'sender_id': uid,
          'content': content,
        })
        .select()
        .single();
    return Message.fromJson(inserted);
  }

  Future<String?> startConversation(String adId, String sellerId) async {
    final uid = supabase.auth.currentUser?.id;
    if (uid == null) return null;
    final conv = await supabase.rpc(
      'start_conversation',
      params: {'p_ad_id': adId, 'p_buyer_id': uid, 'p_seller_id': sellerId},
    );
    return conv?['id'] ?? conv as String?;
  }
}
