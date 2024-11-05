import 'package:bloc/bloc.dart';
import 'package:tickoyakovendors/features/analytics/data/repositories/analytics_repository.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final AnalyticsRepository repository;

  AnalyticsBloc({required this.repository}) : super(AnalyticsInitial()) {
    on<FetchAnalyticsData>(_onFetchAnalyticsData);
  }

  Future<void> _onFetchAnalyticsData(
    FetchAnalyticsData event,
    Emitter<AnalyticsState> emit,
  ) async {
    emit(AnalyticsLoading());
    try {
      final data = await repository.getAnalyticsData();
      emit(AnalyticsLoaded(data));
    } catch (e) {
      emit(AnalyticsError(e.toString()));
    }
  }
}
