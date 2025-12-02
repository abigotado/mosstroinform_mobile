/// Моковые данные для чата
library;

class ChatMockData {
  static const List<Map<String, dynamic>> chats = [
    {
      'id': '1',
      'projectId': '1',
      'specialistName': 'Иван Петров',
      'specialistRole': 'Прораб',
      'lastMessage': 'Добрый день! Фундамент готов к заливке.',
      'lastMessageTime': '2024-01-27T10:30:00Z',
      'unreadCount': 2,
    },
    {
      'id': '2',
      'projectId': '2',
      'specialistName': 'Мария Сидорова',
      'specialistRole': 'Инженер',
      'lastMessage': 'Все документы согласованы.',
      'lastMessageTime': '2024-01-26T15:20:00Z',
      'unreadCount': 0,
    },
  ];

  static const List<Map<String, dynamic>> messages = [
    {
      'id': '1',
      'chatId': '1',
      'senderId': 'specialist',
      'senderName': 'Иван Петров',
      'text': 'Добрый день! Фундамент готов к заливке.',
      'timestamp': '2024-01-27T10:30:00Z',
      'isRead': false,
    },
    {
      'id': '2',
      'chatId': '1',
      'senderId': 'user',
      'senderName': 'Вы',
      'text': 'Отлично, когда планируется заливка?',
      'timestamp': '2024-01-27T10:35:00Z',
      'isRead': true,
    },
    {
      'id': '3',
      'chatId': '1',
      'senderId': 'specialist',
      'senderName': 'Иван Петров',
      'text': 'Завтра утром, если погода позволит.',
      'timestamp': '2024-01-27T10:40:00Z',
      'isRead': false,
    },
  ];

  static List<Map<String, dynamic>> getChatsByProjectId(String projectId) {
    return chats.where((chat) => chat['projectId'] == projectId).toList();
  }

  static List<Map<String, dynamic>> getMessagesByChatId(String chatId) {
    return messages.where((msg) => msg['chatId'] == chatId).toList();
  }

  static Map<String, dynamic>? getChatById(String id) {
    try {
      return chats.firstWhere((chat) => chat['id'] == id);
    } catch (e) {
      return null;
    }
  }
}
