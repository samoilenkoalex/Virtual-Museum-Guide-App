import 'package:mobile/services/api_service.dart';

import '../models/description model.dart';

abstract class DescriptionRepository {
  final ApiService apiService;

  DescriptionRepository(this.apiService);

  Future<DescriptionModel> fetchImageDescription(String imageUrl);
}

class DescriptionRepositoryImpl implements DescriptionRepository {
  @override
  final ApiService apiService;

  DescriptionRepositoryImpl({required this.apiService});

  @override
  Future<DescriptionModel> fetchImageDescription(String imageUrl) async {
    return await apiService.fetchImageDescription(query: imageUrl);
  }
}
