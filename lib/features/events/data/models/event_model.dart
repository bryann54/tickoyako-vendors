import 'package:json_annotation/json_annotation.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventsModel {
  final String id;
  final String type;
  final String imgUrl;
  final String venue;
  final String title;
  final String description;
  final DateTime date;
  final int price;  
  final String eventOwner;
  final String contact;

  EventsModel({
    required this.id,
    required this.contact,
    required this.eventOwner,
    required this.price,
    required this.type,
    required this.venue,
    required this.imgUrl,
    required this.title,
    required this.description,
    required this.date,
  });

  factory EventsModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventModelToJson(this);
}
