import 'package:anakallumkal_app/modules/category/bloc/category_bloc.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:anakallumkal_app/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> categoryPopup(
  BuildContext context,
  TextEditingController controller,
  CategoryBloc bloc, {
  bool isSubCategory = false,
  String id = "",
}) {
  return showDialog(
    context: context,
    builder: (ctx) => BlocConsumer<CategoryBloc, CategoryState>(
      listener: (context, state) {
        if (state is CreateCategorySuccessState) {
          Navigator.pop(context);
          bloc.categories.clear();
          bloc.add(GetAllCategoriesEvent());
        } else if (state is CreateSubCategorySuccessState) {
          Navigator.pop(context);
          bloc.categories.clear();
          bloc.add(GetAllCategoriesEvent());
        } else if (state is UpdateCategorySuccessState) {
          Navigator.pop(context);
          bloc.categories.clear();
          bloc.add(GetAllCategoriesEvent());
        } else if (state is UpdateSubCategorySuccessState) {
          Navigator.pop(context);
          bloc.categories.clear();
          bloc.add(GetAllCategoriesEvent());
        } else if (state is CreateCategoryErrorState) {
          Navigator.pop(context);
          AppCommon.messageDialog(state.message);
        } else if (state is CreateSubCategoryErrorState) {
          Navigator.pop(context);
          AppCommon.messageDialog(state.message);
        } else if (state is UpdateCategoryErrorState) {
          Navigator.pop(context);
          AppCommon.messageDialog(state.message);
        } else if (state is UpdateSubCategoryErrorState) {
          Navigator.pop(context);
          AppCommon.messageDialog(state.message);
        }
      },
      bloc: bloc,
      builder: (context, state) {
        return AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 24),
          content: SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Column(
                children: [
                  Text(
                    "Create ${isSubCategory ? "Sub-" : ""}Category",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  TextBoxWidget(
                    title: "${isSubCategory ? "Sub-" : ""}Category Name",
                    controller: controller,
                    isRequired: true,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFF0a2540),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {
                          if (isSubCategory) {
                            if (id.isNotEmpty) {
                              bloc.add(
                                UpdateSubCategoriesEvent(
                                  id: id,
                                  name: controller.text.trim(),
                                ),
                              );
                            } else {
                              bloc.add(
                                CreateSubCategoriesEvent(
                                  name: controller.text.trim(),
                                ),
                              );
                            }
                          } else {
                            if (id.isNotEmpty) {
                              bloc.add(
                                UpdateCategoriesEvent(
                                  id: id,
                                  name: controller.text.trim(),
                                ),
                              );
                            } else {
                              bloc.add(
                                CreateCategoriesEvent(
                                  name: controller.text.trim(),
                                ),
                              );
                            }
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: Row(
                            children: [
                              Text(
                                id.isEmpty ? "Create" : "Update",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              if (state is CreateCategoryLoadingState ||
                                  state is UpdateCategoryLoadingState)
                                Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

class TextBoxWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isRequired;
  const TextBoxWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.isRequired,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.titleSmall,
            children: [
              if (isRequired)
                const TextSpan(
                  text: " *",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        TextFormField(
          controller: controller,
          inputFormatters:
              title == "Price" || title == "Stock" || title == "Rows"
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [],
          keyboardType: title == "Price" || title == "Stock" || title == "Rows"
              ? TextInputType.number
              : null,
          validator: (value) {
            if (isRequired && (value ?? "").trim().isEmpty) {
              return "$title is Required";
            }
            return null;
          },
          style: Theme.of(context).textTheme.titleSmall,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
            errorStyle: const TextStyle(color: Colors.red),
            hintText: "Enter $title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
