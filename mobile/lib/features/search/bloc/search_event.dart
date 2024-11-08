part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
}

final class FetchSearchResult extends SearchEvent {
  final String query;

  const FetchSearchResult(this.query);

  @override
  List<Object> get props => [query];
}

final class SearchInputChanged extends SearchEvent {
  final String query;

  const SearchInputChanged(this.query);

  @override
  List<Object> get props => [query];
}
