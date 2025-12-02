// Моковые данные для этапа строительства

class ConstructionMockData {
  static const List<Map<String, dynamic>> cameras = [
    {
      'id': '1',
      'projectId': '1',
      'name': 'Камера 1',
      'streamUrl': 'https://example.com/stream/camera1',
      'thumbnailUrl': 'https://via.placeholder.com/400x300?text=Камера+1',
      'isActive': true,
      'lastUpdate': '2024-01-27T11:26:00Z',
    },
    {
      'id': '2',
      'projectId': '1',
      'name': 'Камера 2',
      'streamUrl': 'https://example.com/stream/camera2',
      'thumbnailUrl': 'https://via.placeholder.com/400x300?text=Камера+2',
      'isActive': true,
      'lastUpdate': '2024-01-27T11:25:00Z',
    },
    {
      'id': '3',
      'projectId': '1',
      'name': 'Камера 3',
      'streamUrl': 'https://example.com/stream/camera3',
      'thumbnailUrl': 'https://via.placeholder.com/400x300?text=Камера+3',
      'isActive': false,
      'lastUpdate': '2024-01-27T10:15:00Z',
    },
  ];

  static const List<Map<String, dynamic>> photoReports = [
    {
      'id': '1',
      'projectId': '1',
      'stageId': '2',
      'photos': [
        'https://via.placeholder.com/400x300?text=Фото+1',
        'https://via.placeholder.com/400x300?text=Фото+2',
      ],
      'date': '2024-01-27',
      'comment': 'Арматура уложена верно',
    },
  ];

  static List<Map<String, dynamic>> getCamerasByProjectId(String projectId) {
    return cameras.where((cam) => cam['projectId'] == projectId).toList();
  }

  static List<Map<String, dynamic>> getPhotoReportsByProjectId(
    String projectId,
  ) {
    return photoReports
        .where((report) => report['projectId'] == projectId)
        .toList();
  }
}
