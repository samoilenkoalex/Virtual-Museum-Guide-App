import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/network/exceptions/api_exceptions.dart';
import '../models/artwork_model.dart';
import '../repositories/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc({required this.searchRepository}) : super(const SearchInitial()) {
    on<FetchSearchResult>(_onFetchSearchResult);
    on<SearchInputChanged>(_onSearchInputChanged);
  }

  Future<void> _onFetchSearchResult(FetchSearchResult event, Emitter<SearchState> emit) async {
    final currentQuery = state.query;
    emit(SearchLoading(query: currentQuery));

    try {
      final result = await searchRepository.fetchSearchResult(currentQuery);

      final List<Artwork> resultsWithImages = result.result.results
          .where(
            (artwork) => artwork.primaryImage.isNotEmpty,
          )
          .toList();
      if (result.result.results.isNotEmpty) {
        emit(SearchLoaded(result: resultsWithImages, query: currentQuery));
      } else {
        emit(SearchError(message: 'No results found', query: currentQuery));
      }
    } on ApiException catch (e) {
      log('API Error: ${e.message}');
      if (e.statusCode != null) {
        log('Status Code: ${e.statusCode}');
      }
      emit(SearchError(message: e.message, query: currentQuery));
    } catch (e) {
      log('Unexpected error: $e');
      emit(SearchError(message: e.toString(), query: currentQuery));
    }
  }

  void _onSearchInputChanged(SearchInputChanged event, Emitter<SearchState> emit) {
    emit(SearchInputChangedState(query: event.query));
  }
}
