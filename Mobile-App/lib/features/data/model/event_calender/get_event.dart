class GetEvent {
  String id;
  String date;
  String title;
  String time;

  GetEvent({
    required this.id,
    required this.date,
    required this.title,
    required this.time,
  });

  factory GetEvent.fromJson(Map<String, dynamic> json) {
    return GetEvent(
      id: json['id'].toString(),
      date: json['date'].toString(),
      title: json['title'],
      time: json['time'].toString(),
    );
  }

  static List<GetEvent> parseDataList(dynamic json) {
    if (json['success'] == true &&
        json['data'] != null &&
        json['data']['data'] is List) {
      var list = json['data']['data'] as List;
      return list.map((data) => GetEvent.fromJson(data)).toList();
    } else {
      throw Exception('Invalid JSON structure');
    }
  }

  @override
  String toString() {
    return 'GetEvent{id: $id, date: $date, title: $title, time: $time}';
  }
}
