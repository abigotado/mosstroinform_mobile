// Моковые данные для документов

class DocumentsMockData {
  static const List<Map<String, dynamic>> documents = [
    {
      'id': '1',
      'projectId': '1',
      'name': 'Проектная документация',
      'type': 'project',
      'status': 'approved',
      'fileUrl': 'https://example.com/docs/project.pdf',
      'uploadDate': '2024-01-15',
      'approvalDate': '2024-01-20',
    },
    {
      'id': '2',
      'projectId': '1',
      'name': 'Разрешение на строительство',
      'type': 'permit',
      'status': 'approved',
      'fileUrl': 'https://example.com/docs/permit.pdf',
      'uploadDate': '2024-01-18',
      'approvalDate': '2024-01-22',
    },
    {
      'id': '3',
      'projectId': '1',
      'name': 'Договор подряда',
      'type': 'contract',
      'status': 'pending',
      'fileUrl': 'https://example.com/docs/contract.pdf',
      'uploadDate': '2024-01-25',
      'approvalDate': null,
    },
    {
      'id': '4',
      'projectId': '1',
      'name': 'Смета на материалы',
      'type': 'estimate',
      'status': 'pending',
      'fileUrl': 'https://example.com/docs/estimate.pdf',
      'uploadDate': '2024-01-26',
      'approvalDate': null,
    },
  ];

  static List<Map<String, dynamic>> getDocumentsByProjectId(String projectId) {
    return documents.where((doc) => doc['projectId'] == projectId).toList();
  }

  static Map<String, dynamic>? getDocumentById(String id) {
    try {
      return documents.firstWhere((doc) => doc['id'] == id);
    } catch (e) {
      return null;
    }
  }
}

