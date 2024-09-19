part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class GetAllCategoriesLoadingState extends CategoryState {}

final class GetAllCategoriesSuccessState extends CategoryState {
  @override
  List<Object> get props => [];
}

final class GetAllCategoriesErrorState extends CategoryState {
  final String message;

  const GetAllCategoriesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class CreateCategoryLoadingState extends CategoryState {}

final class CreateCategorySuccessState extends CategoryState {
  @override
  List<Object> get props => [];
}

final class CreateCategoryErrorState extends CategoryState {
  final String message;

  const CreateCategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateCategoryLoadingState extends CategoryState {}

final class UpdateCategorySuccessState extends CategoryState {
  @override
  List<Object> get props => [];
}

final class UpdateCategoryErrorState extends CategoryState {
  final String message;

  const UpdateCategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class CreateSubCategoryLoadingState extends CategoryState {}

final class CreateSubCategorySuccessState extends CategoryState {
  @override
  List<Object> get props => [];
}

final class CreateSubCategoryErrorState extends CategoryState {
  final String message;

  const CreateSubCategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateSubCategoryLoadingState extends CategoryState {}

final class UpdateSubCategorySuccessState extends CategoryState {
  @override
  List<Object> get props => [];
}

final class UpdateSubCategoryErrorState extends CategoryState {
  final String message;

  const UpdateSubCategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeleteCategoryLoadingState extends CategoryState {}

final class DeleteCategorySuccessState extends CategoryState {
  @override
  List<Object> get props => [];
}

final class DeleteCategoryErrorState extends CategoryState {
  final String message;

  const DeleteCategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeleteSubCategoryLoadingState extends CategoryState {}

final class DeleteSubCategorySuccessState extends CategoryState {
  @override
  List<Object> get props => [];
}

final class DeleteSubCategoryErrorState extends CategoryState {
  final String message;

  const DeleteSubCategoryErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateStateState extends CategoryState {
  final DateTime dateTime;

  const UpdateStateState({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}
