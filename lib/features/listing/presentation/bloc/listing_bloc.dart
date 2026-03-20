import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bharatnxt/features/listing/data/models/pagination_meta_model.dart';
import 'package:bharatnxt/features/listing/data/models/suggestion_model.dart';
import 'package:bharatnxt/features/listing/domain/usecases/get_suggestions_usecase.dart';

part 'listing_event.dart';
part 'listing_state.dart';

class ListingBloc extends Bloc<ListingEvent, ListingState> {
  final GetSuggestionsUseCase _getSuggestions;

  ListingBloc(this._getSuggestions) : super(const ListingInitialState()) {
    on<LoadSuggestionsEvent>(_onLoad);
    on<GoToPageEvent>(_onGoToPage);
  }

  Future<void> _onLoad(
    LoadSuggestionsEvent event,
    Emitter<ListingState> emit,
  ) async {
    emit(const ListingLoadingState());
    await _fetchPage(page: event.page, limit: event.limit, emit: emit);
  }

  Future<void> _onGoToPage(
    GoToPageEvent event,
    Emitter<ListingState> emit,
  ) async {
    emit(const ListingLoadingState());
    await _fetchPage(page: event.page, limit: event.limit, emit: emit);
  }

  Future<void> _fetchPage({
    required int page,
    required int limit,
    required Emitter<ListingState> emit,
  }) async {
    try {
      final result = await _getSuggestions(page: page, limit: limit);
      emit(ListingLoadedState(
        suggestions: result.suggestions,
        pagination: result.pagination,
      ));
    } catch (e) {
      emit(ListingErrorState(e.toString()));
    }
  }
}
