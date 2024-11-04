// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsModel _$EventModelFromJson(Map<String, dynamic> json) => EventsModel(
      id: json['id'] as String,
      contact: json['contact'] as String,
      eventOwner: json['eventOwner'] as String,
      price: (json['price'] as num).toInt(),
      type: json['type'] as String,
      venue: json['venue'] as String,
      imgUrl: json['imgUrl'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$EventModelToJson(EventsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'imgUrl': instance.imgUrl,
      'venue': instance.venue,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'price': instance.price,
      'eventOwner': instance.eventOwner,
      'contact': instance.contact,
    };
