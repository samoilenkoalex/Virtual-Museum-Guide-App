import 'package:mobile/services/api_service.dart';

import '../models/artwork_model.dart';


abstract class SearchRepository {
  final ApiService apiService;

  SearchRepository({required this.apiService});

  Future<ArtworkModel> fetchSearchResult(String query);
}

class SearchRepositoryImpl implements SearchRepository {
  @override
  final ApiService apiService;

  SearchRepositoryImpl({required this.apiService});

  @override
  Future<ArtworkModel> fetchSearchResult(String query) async {
    return await apiService.searchTopic(query: query);
  }
}
