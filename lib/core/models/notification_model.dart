class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String payload;
  final String date;
  int click;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
    required this.date,
    this.click = 0,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'body': body,
        'payload': payload,
        'date': date,
        'click': click,
      };

  static NotificationModel fromMap(Map<String, dynamic> map) =>
      NotificationModel(
        id: map['id'] as String,
        title: map['title'] as String,
        body: map['body'] as String,
        payload: map['payload'] as String,
        date: map['date'] as String,
        click: map['click'] as int,
      );
}
