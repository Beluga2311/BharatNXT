part of 'listing_bloc.dart';

sealed class ListingEvent {
  const ListingEvent();
}

final class LoadSuggestionsEvent extends ListingEvent {
  final int page;
  final int limit;
  const LoadSuggestionsEvent({this.page = 1, this.limit = 10});
}

final class GoToPageEvent extends ListingEvent {
  final int page;
  final int limit;
  const GoToPageEvent({required this.page, required this.limit});
}
