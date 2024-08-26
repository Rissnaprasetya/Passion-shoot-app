import 'package:proj_passion_shoot/features/data/model/event_calender/get_event.dart';

class PostEvent {
  final int? id; // Gunakan tipe data nullable untuk id
  final String date;
  final String title;
  final String time;

  PostEvent({
    this.id, // Jadikan id menjadi nullable
    required this.date,
    required this.title,
    required this.time,
  });

  // Constructor bernama untuk mengonversi GetEvent menjadi PostEvent
  PostEvent.fromGetEvent(GetEvent getEvent)
      : id =
            null, // Tetapkan id menjadi null karena tidak tersedia dari GetEvent
        date = getEvent.date,
        title = getEvent.title,
        time = getEvent.time;

  factory PostEvent.fromJson(Map<String, dynamic> json) {
    return PostEvent(
      id: json['id'], // Tambahkan penanganan nilai null untuk id
      date: json['date'],
      title: json['title'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Tambahkan penanganan nilai null untuk id
      'date': date,
      'title': title,
      'time': time,
    };
  }
}
