// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_rating_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieRatingModel _$MovieRatingModelFromJson(Map<String, dynamic> json) =>
    MovieRatingModel(
      imdbId: json['imdbId'] as String,
      rating: (json['rating'] as num).toDouble(),
      votes: (json['votes'] as num).toInt(),
    );

Map<String, dynamic> _$MovieRatingModelToJson(MovieRatingModel instance) =>
    <String, dynamic>{
      'imdbId': instance.imdbId,
      'rating': instance.rating,
      'votes': instance.votes,
    };
