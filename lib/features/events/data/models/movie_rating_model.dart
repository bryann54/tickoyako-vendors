import 'package:json_annotation/json_annotation.dart';

part 'movie_rating_model.g.dart';

@JsonSerializable()
class MovieRatingModel {
  final String imdbId;
  final double rating;
  final int votes;

  MovieRatingModel({
    required this.imdbId,
    required this.rating,
    required this.votes,
  });

  factory MovieRatingModel.fromJson(Map<String, dynamic> json) =>
      _$MovieRatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieRatingModelToJson(this);
}
