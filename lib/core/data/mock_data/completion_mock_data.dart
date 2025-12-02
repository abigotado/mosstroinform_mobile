/// Моковые данные для завершения строительства
library;

class CompletionMockData {
  static const List<Map<String, dynamic>> finalDocuments = [
    {
      'id': '1',
      'projectId': '1',
      'name': 'Акт приёмки-передачи',
      'type': 'acceptance',
      'status': 'pending',
      'fileUrl': 'https://example.com/docs/acceptance.pdf',
      'uploadDate': '2024-01-28',
      'signatureRequired': true,
    },
    {
      'id': '2',
      'projectId': '1',
      'name': 'Гарантийное обязательство',
      'type': 'warranty',
      'status': 'pending',
      'fileUrl': 'https://example.com/docs/warranty.pdf',
      'uploadDate': '2024-01-28',
      'signatureRequired': true,
    },
    {
      'id': '3',
      'projectId': '1',
      'name': 'Финальный отчёт',
      'type': 'final_report',
      'status': 'pending',
      'fileUrl': 'https://example.com/docs/final_report.pdf',
      'uploadDate': '2024-01-28',
      'signatureRequired': false,
    },
  ];

  static List<Map<String, dynamic>> getFinalDocumentsByProjectId(
    String projectId,
  ) {
    return finalDocuments
        .where((doc) => doc['projectId'] == projectId)
        .toList();
  }

  static Map<String, dynamic>? getFinalDocumentById(String id) {
    try {
      return finalDocuments.firstWhere((doc) => doc['id'] == id);
    } catch (e) {
      return null;
    }
  }
}
