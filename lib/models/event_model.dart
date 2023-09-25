import 'dart:convert';

class EventModel {
  final int id;
  final String title;
  final String description;
  final String banner_image;
  final String date_time;
  final String organiser_name;
  final String organiser_icon;
  final String venue_name;
  final String venue_city;
  final String venue_country;
  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.banner_image,
    required this.date_time,
    required this.organiser_name,
    required this.organiser_icon,
    required this.venue_name,
    required this.venue_city,
    required this.venue_country,
  });

  Map<String, dynamic> toMap() {
    return {
        "id": id,
        "title": title,
        "description": description,
        "banner_image": banner_image,
        "date_time":date_time,
        "organiser_name": organiser_name,
        "organiser_icon": organiser_icon,
        "venue_name": venue_name,
        "venue_city": venue_city,
        "venue_country": venue_country,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] ?? 1,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      banner_image: map['banner_image'] ?? '',
      date_time: map['date_time'] ?? '',
      organiser_name: map['organiser_name'] ?? '',
      organiser_icon: map['organiser_icon'] ?? '',
      venue_name: map['venue_name'] ?? '',
      venue_city: map['venue_city'] ?? '',
      venue_country: map['venue_country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));
}
