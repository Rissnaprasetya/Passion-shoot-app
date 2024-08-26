class DataEvent {
  final List<Event> data;

  DataEvent({required this.data});

  factory DataEvent.fromJson(Map<String, dynamic> json) =>
      DataEvent(
          data: List.from(json['data'].map(
        (event) => Event.fromJson(event),
      )));
}

class Event {
  final int? id;
  final String date;
  final String title;
  final String time;

  Event({
    this.id,
    required this.date,
    required this.title,
    required this.time,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json['id'],
        date: json['date'].toString(),
        title: json['title'],
        time: json['time'].toString(),
      );

  Map<String, dynamic> toJson() => {
    'date': date,
    'title': title,
    'time': time,
  };
}
