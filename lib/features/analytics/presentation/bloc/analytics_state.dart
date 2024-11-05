part of 'analytics_bloc.dart';
abstract class AnalyticsState {}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {
  final Map<String, dynamic> analyticsData;
  AnalyticsLoaded(this.analyticsData);
}

class AnalyticsError extends AnalyticsState {
  final String message;
  AnalyticsError(this.message);
}
