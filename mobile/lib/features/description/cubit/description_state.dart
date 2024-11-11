part of 'description_cubit.dart';

sealed class DescriptionState {}

class DescriptionInitial extends DescriptionState {}

class DescriptionLoading extends DescriptionState {}

class DescriptionLoaded extends DescriptionState {
  final dynamic description;

  DescriptionLoaded(this.description);
}

class DescriptionError extends DescriptionState {
  final String message;

  DescriptionError(this.message);
}
