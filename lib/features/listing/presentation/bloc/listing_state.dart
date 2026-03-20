part of 'listing_bloc.dart';

sealed class ListingState extends Equatable {
  const ListingState();
}

final class ListingInitialState extends ListingState {
  const ListingInitialState();

  @override
  List<Object?> get props => [];
}

final class ListingLoadingState extends ListingState {
  const ListingLoadingState();

  @override
  List<Object?> get props => [];
}

final class ListingLoadedState extends ListingState {
  final List<SuggestionModel> suggestions;
  final PaginationMetaModel pagination;

  const ListingLoadedState({
    required this.suggestions,
    required this.pagination,
  });

  @override
  List<Object?> get props => [suggestions, pagination];

  ListingLoadedState copyWith({
    List<SuggestionModel>? suggestions,
    PaginationMetaModel? pagination,
  }) =>
      ListingLoadedState(
        suggestions: suggestions ?? this.suggestions,
        pagination: pagination ?? this.pagination,
      );
}

final class ListingErrorState extends ListingState {
  final String message;

  const ListingErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
