part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class GetAllCategoriesEvent extends CategoryEvent {}

class CreateCategoriesEvent extends CategoryEvent {
  final String name;

  const CreateCategoriesEvent({required this.name});
}

class CreateSubCategoriesEvent extends CategoryEvent {
  final String name;

  const CreateSubCategoriesEvent({required this.name});
}

class UpdateCategoriesEvent extends CategoryEvent {
  final String id;
  final String name;

  const UpdateCategoriesEvent({required this.id, required this.name});
}

class UpdateSubCategoriesEvent extends CategoryEvent {
  final String id;
  final String name;

  const UpdateSubCategoriesEvent({required this.id, required this.name});
}

class DeleteCategoriesEvent extends CategoryEvent {
  final String id;

  const DeleteCategoriesEvent({required this.id});
}

class DeleteSubCategoriesEvent extends CategoryEvent {
  final String id;

  const DeleteSubCategoriesEvent({required this.id});
}

final class UpdateStateEvent extends CategoryEvent {}
