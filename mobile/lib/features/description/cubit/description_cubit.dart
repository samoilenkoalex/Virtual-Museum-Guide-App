import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/network/exceptions/api_exceptions.dart';
import '../repositories/description_repository.dart';

part 'description_state.dart';

class DescriptionCubit extends Cubit<DescriptionState> {
  final DescriptionRepository descriptionRepository;

  DescriptionCubit({required this.descriptionRepository}) : super(DescriptionInitial());

  Future<void> fetchDescriptionResult(String imageUrl) async {
    emit(DescriptionLoading());

    try {
      final result = await descriptionRepository.fetchImageDescription(imageUrl);
      emit(DescriptionLoaded(result));
    } on ApiException catch (e) {
      if (e.statusCode != null) {
        log('Status Code: ${e.statusCode}');
      }
      emit(DescriptionError(e.message));
    } catch (e) {
      log('Unexpected error: $e');
      emit(DescriptionError(e.toString()));
    }
  }
}
