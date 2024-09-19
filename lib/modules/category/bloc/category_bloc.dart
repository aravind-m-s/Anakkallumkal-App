import 'dart:convert';

import 'package:anakallumkal_app/api/api_provider.dart';
import 'package:anakallumkal_app/modules/category/model/category_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final List<CategoryModel> categories = [];
  CategoryModel? currentCategory;

  CategoryBloc() : super(CategoryInitial()) {
    on<UpdateStateEvent>(
        (_, emit) => emit(UpdateStateState(dateTime: DateTime.now())));
    on<GetAllCategoriesEvent>(getAllCategoriesBloc);
    on<CreateCategoriesEvent>(createCategoriesBloc);
    on<CreateSubCategoriesEvent>(createSubCategoriesBloc);
    on<UpdateCategoriesEvent>(updateCategoriesBloc);
    on<UpdateSubCategoriesEvent>(updateSubCategoriesBloc);
    on<DeleteCategoriesEvent>(deleteCategoriesBloc);
    on<DeleteSubCategoriesEvent>(deleteSubCategoriesBloc);
  }

  getAllCategoriesBloc(
    GetAllCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(GetAllCategoriesLoadingState());
      if (categories.isNotEmpty) {
        emit(GetAllCategoriesSuccessState());
        return;
      }
      final response = await ApiProvider.getAllCategories();
      if (response.statusCode == 200) {
        if (response.body != "null" && response.body != "[]") {
          categories.clear();
          jsonDecode(response.body).forEach((element) {
            final category = CategoryModel.fromJson(element);
            categories.add(
              category,
            );
            if (currentCategory?.id == category.id) {
              currentCategory = category;
            }
          });
          currentCategory ??= categories.first;
        }

        emit(GetAllCategoriesSuccessState());
      } else {
        emit(
          GetAllCategoriesErrorState(
            message: jsonDecode(response.body)['message'] ??
                "Something went wrong, Please try again later",
          ),
        );
      }
    } catch (e) {
      emit(const GetAllCategoriesErrorState(message: "Internal Error Occured"));
    }
  }

  createCategoriesBloc(
    CreateCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(CreateCategoryLoadingState());
      if (event.name.trim().isEmpty) {
        emit(const CreateCategoryErrorState(message: "Name cannot be empty"));
        return;
      }
      final response = await ApiProvider.createCategory(event.name);
      if (response.statusCode == 200) {
        emit(CreateCategorySuccessState());
      } else {
        emit(CreateCategoryErrorState(
            message: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(const CreateCategoryErrorState(message: "Internal Error Occured"));
    }
  }

  createSubCategoriesBloc(
    CreateSubCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(CreateSubCategoryLoadingState());
      if (event.name.trim().isEmpty) {
        emit(
            const CreateSubCategoryErrorState(message: "Name cannot be empty"));
        return;
      }
      final response = await ApiProvider.createSubCategory(
          event.name, currentCategory?.id ?? "");
      if (response.statusCode == 200) {
        emit(CreateSubCategorySuccessState());
      } else {
        emit(CreateSubCategoryErrorState(
            message: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(
          const CreateSubCategoryErrorState(message: "Internal Error Occured"));
    }
  }

  updateCategoriesBloc(
    UpdateCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(UpdateCategoryLoadingState());
      final response = await ApiProvider.editCategory(event.name, event.id);
      if (response.statusCode == 200) {
        emit(UpdateCategorySuccessState());
      } else {
        emit(UpdateCategoryErrorState(
            message: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(const UpdateCategoryErrorState(message: "Internal Error Occured"));
    }
  }

  updateSubCategoriesBloc(
    UpdateSubCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(UpdateSubCategoryLoadingState());
      if (event.name.trim().isEmpty) {
        emit(
            const UpdateSubCategoryErrorState(message: "Name cannot be empty"));
        return;
      }
      final response = await ApiProvider.editSubCategory(
          event.name, event.id, currentCategory?.id ?? "");
      if (response.statusCode == 200) {
        emit(UpdateSubCategorySuccessState());
      } else {
        emit(UpdateSubCategoryErrorState(
            message: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(
          const UpdateSubCategoryErrorState(message: "Internal Error Occured"));
    }
  }

  deleteCategoriesBloc(
    DeleteCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {}

  deleteSubCategoriesBloc(
    DeleteSubCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(DeleteSubCategoryLoadingState());
      final response = await ApiProvider.deleteSubCategory(event.id);
      if (response.statusCode == 200) {
        emit(DeleteSubCategorySuccessState());
      } else {
        emit(DeleteSubCategoryErrorState(
            message: jsonDecode(response.body)['message']));
      }
    } catch (e) {
      emit(
          const DeleteSubCategoryErrorState(message: "Internal Error Occured"));
    }
  }
}
