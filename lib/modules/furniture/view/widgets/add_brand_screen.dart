import 'dart:io';

import 'package:anakallumkal_app/api/api_urls.dart';
import 'package:anakallumkal_app/modules/furniture/bloc/furniture_bloc.dart';
import 'package:anakallumkal_app/modules/furniture/model/brand_model.dart';
import 'package:anakallumkal_app/modules/furniture/model/shop_model.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddBrandScreen extends StatefulWidget {
  final dynamic editItem;
  final List<ShopModel> shops;
  const AddBrandScreen({super.key, this.editItem, required this.shops});

  @override
  State<AddBrandScreen> createState() => _AddBrandScreenState();
}

class _AddBrandScreenState extends State<AddBrandScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController shopController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String imagePath = '';
  String imageError = '';
  String shopId = '';

  @override
  void initState() {
    super.initState();
    if (widget.editItem != null && widget.editItem.runtimeType == BrandModel) {
      final BrandModel model = widget.editItem;
      nameController.text = model.name;
      shopController.text = model.shop.name;
      shopId = model.shop.id;
      imagePath = ApiUrls.mediaUrl + model.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width > 400
          ? 400
          : MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: BlocConsumer<FurnitureBloc, FurnitureState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add New Brand",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.editItem == null) {
                            Navigator.of(context).pop();
                          } else {
                            final bloc = context.read<FurnitureBloc>();
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                scrollable: true,
                                content: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Are you sure!!!",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "Do you want to delete ${widget.editItem.name}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 24),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 32,
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                                          BlocBuilder<FurnitureBloc,
                                              FurnitureState>(
                                            bloc: context.read<FurnitureBloc>(),
                                            builder: (context, state) {
                                              return GestureDetector(
                                                onTap: () {
                                                  bloc.add(
                                                    DeleteBrandEvent(
                                                      id: widget.editItem.id,
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 32,
                                                    vertical: 8,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      if (state
                                                              is CreateFurnitureLoadingState ||
                                                          state
                                                              is UpdateFurnitureLoadingState)
                                                        Transform.scale(
                                                          scale: 0.5,
                                                          child:
                                                              const CircularProgressIndicator(
                                                            color: Colors.white,
                                                            strokeWidth: 3,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color: widget.editItem == null
                                    ? Theme.of(context).iconTheme.color!
                                    : Colors.red),
                          ),
                          child: Icon(
                            widget.editItem != null
                                ? Icons.delete
                                : Icons.close,
                            size: 20,
                            color: widget.editItem == null
                                ? Theme.of(context).iconTheme.color!
                                : Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  TextBoxWidget(
                    title: "Brand Name",
                    controller: nameController,
                    isRequired: true,
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: "Shop",
                      style: Theme.of(context).textTheme.titleSmall,
                      children: const [
                        TextSpan(
                          text: " *",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: CustomDropdown.search(
                      decoration: CustomDropdownDecoration(
                        closedBorderRadius: BorderRadius.circular(8),
                        closedBorder: Border.all(
                          color: Theme.of(context).iconTheme.color!,
                          width: 0.5,
                        ),
                        closedFillColor: Colors.transparent,
                        headerStyle: Theme.of(context).textTheme.titleSmall,
                        expandedFillColor:
                            Theme.of(context).secondaryHeaderColor,
                        listItemStyle: Theme.of(context).textTheme.titleSmall,
                        searchFieldDecoration: SearchFieldDecoration(
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      initialItem: shopId.isEmpty
                          ? null
                          : widget.shops
                              .firstWhere(
                                (element) => element.id == shopId,
                              )
                              .name,
                      hintText: "Select Shop",
                      items: widget.shops
                          .map(
                            (e) => e.name,
                          )
                          .toList(),
                      closedHeaderPadding: const EdgeInsets.all(12),
                      searchHintText: "Search Shop",
                      excludeSelected: false,
                      onChanged: (p0) {
                        if (p0 != null) {
                          shopId = widget.shops
                              .firstWhere((element) => element.name == p0)
                              .id;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text.rich(
                    TextSpan(
                      text: "Brand Image",
                      style: Theme.of(context).textTheme.titleSmall,
                      children: const [
                        TextSpan(
                          text: " *",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await ImagePicker()
                              .pickImage(source: ImageSource.gallery)
                              .then((image) {
                            if (image != null) {
                              imagePath = image.path;
                              imageError = '';
                            }
                            context
                                .read<FurnitureBloc>()
                                .add(UpdateStateEvent());
                          });
                        },
                        child: DottedBorder(
                          dashPattern: const [8, 8],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          strokeWidth: imageError.isNotEmpty ? 2 : 1,
                          color: imageError.isNotEmpty
                              ? Colors.red
                              : Theme.of(context).iconTheme.color!,
                          child: SizedBox(
                            height: 150,
                            width: 150,
                            child: imagePath.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.file_upload_outlined,
                                        size: 50,
                                      ),
                                      Text(
                                        "Upload Brand Image",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      )
                                    ],
                                  )
                                : imagePath.startsWith("http")
                                    ? CachedNetworkImage(imageUrl: imagePath)
                                    : Image.file(
                                        File(imagePath),
                                      ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (imageError != "") const SizedBox(height: 8),
                  if (imageError != "")
                    Text(
                      imageError,
                      style: const TextStyle(color: Colors.red),
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
                      GestureDetector(
                        onTap: () {
                          if (widget.editItem == null &&
                              formKey.currentState!.validate()) {
                            context.read<FurnitureBloc>().add(
                                  CreateBrandEvent(
                                    name: nameController.text.trim(),
                                    shop: shopId,
                                    image: imagePath,
                                  ),
                                );
                          } else if (imagePath.isEmpty) {
                            context
                                .read<FurnitureBloc>()
                                .add(UpdateStateEvent());
                            imageError = "Furniture Image is Required";
                            return;
                          } else if (widget.editItem != null) {
                            context.read<FurnitureBloc>().add(
                                  UpdateBrandEvent(
                                    id: widget.editItem.id,
                                    name: nameController.text.trim(),
                                    shop: shopId,
                                    image: imagePath,
                                  ),
                                );
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: state is CreateBrandLoadingState ||
                                    state is UpdateBrandLoadingState
                                ? 16
                                : 32,
                            vertical: state is CreateBrandLoadingState ||
                                    state is UpdateBrandLoadingState
                                ? 2
                                : 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primaryColor,
                          ),
                          child: Row(
                            children: [
                              Text(
                                widget.editItem != null ? "Update" : "Create",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              if (state is CreateBrandLoadingState ||
                                  state is UpdateBrandLoadingState)
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
          );
        },
      ),
    );
  }
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
          style: Theme.of(context).textTheme.titleSmall,
          inputFormatters: title == "Price" || title == "Stock"
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          keyboardType: title == "Price" || title == "Stock"
              ? TextInputType.number
              : null,
          validator: (value) {
            if (isRequired && (value ?? "").trim().isEmpty) {
              return "$title is Required";
            }
            return null;
          },
          decoration: InputDecoration(
            errorStyle: const TextStyle(color: Colors.red),
            hintText: "Enter $title",
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
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
