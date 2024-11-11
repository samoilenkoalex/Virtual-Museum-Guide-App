import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/description/repositories/description_repository.dart';
import '../../features/search/repositories/search_repository.dart';
import '../../services/api_service.dart';

class RepositoriesHolder extends StatelessWidget {
  final Widget child;

  const RepositoriesHolder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = GetIt.I<ApiService>();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DescriptionRepository>(
          create: (context) => DescriptionRepositoryImpl(
            apiService: apiService,
          ),
        ),
        RepositoryProvider<SearchRepository>(
          create: (context) => SearchRepositoryImpl(
            apiService: apiService,
          ),
        ),
      ],
      child: child,
    );
  }
}
