import 'package:anakallumkal_app/modules/category/bloc/category_bloc.dart';
import 'package:anakallumkal_app/modules/category/view/widgets/dialog_widget.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:anakallumkal_app/utils/app_common.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({
    super.key,
  });

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  final Debouncer debouncer = Debouncer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width > 1120
              ? 450
              : MediaQuery.of(context).size.width > 920
                  ? 250
                  : 0),
      child: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is DeleteSubCategoryErrorState) {
            AppCommon.messageDialog(state.message);
          } else if (state is DeleteCategorySuccessState) {
            context.read<CategoryBloc>().categories.clear();
            context.read<CategoryBloc>().add(GetAllCategoriesEvent());
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: MediaQuery.of(context).size.width > 920 ? 24 : 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (MediaQuery.of(context).size.width > 600)
                      Text(
                        "Manage Sub-Categories",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width <= 600
                              ? MediaQuery.of(context).size.width - 150
                              : MediaQuery.of(context).size.width > 670
                                  ? 250
                                  : 200,
                          height: 40,
                          child: TextField(
                            onChanged: (value) {
                              debouncer.run(
                                () {},
                              );
                            },
                            decoration: InputDecoration(
                              prefixIcon: Transform.scale(
                                scale: 0.5,
                                child: SvgPicture.asset(
                                    "assets/svgs/search_icon.svg"),
                              ),
                              hintText: "Search Furnitures",

                              // ignore: prefer_const_constructors
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade400),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: Theme.of(context).dividerColor),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              focusColor: AppColors.primaryColor,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: context.read<CategoryBloc>().categories.isEmpty &&
                          (state is! GetAllCategoriesLoadingState ||
                              state is! CategoryInitial)
                      ? Center(
                          child: Text(
                            "No Sub-Categories available",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width > 920
                                ? 24
                                : 0,
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: MediaQuery.of(context).size.width >
                                            920
                                        ? null
                                        : () {
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Colors.white,
                                              isScrollControlled: true,
                                              builder: (context) => SizedBox(
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2) +
                                                    MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child:
                                                    selectBrandPopup(context),
                                              ),
                                            );
                                          },
                                    child: Row(
                                      children: [
                                        Skeletonizer(
                                          effect: ShimmerEffect(
                                            baseColor: AppColors.primaryColor
                                                .withOpacity(0.4),
                                            highlightColor: AppColors
                                                .primaryColor
                                                .withOpacity(0.3),
                                          ),
                                          enabled: state
                                              is GetAllCategoriesLoadingState,
                                          child: state
                                                      is! GetAllCategoriesLoadingState &&
                                                  context
                                                          .read<CategoryBloc>()
                                                          .currentCategory!
                                                          .name !=
                                                      ""
                                              ? BlocBuilder<CategoryBloc,
                                                  CategoryState>(
                                                  builder: (context, state) {
                                                    return Text(
                                                      "${context.read<CategoryBloc>().currentCategory!.name} ( ${context.read<CategoryBloc>().currentCategory!.subCategories.length} )",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    );
                                                  },
                                                )
                                              : state is GetAllCategoriesLoadingState
                                                  ? const Text(
                                                      "Brand Name",
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    )
                                                  : const Text(""),
                                        ),
                                        if (MediaQuery.of(context).size.width <=
                                            920)
                                          const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Expanded(
                                child: AnimationLimiter(
                                  child: GridView.builder(
                                    itemCount:
                                        state is GetAllCategoriesLoadingState
                                            ? 31
                                            : (context
                                                    .read<CategoryBloc>()
                                                    .currentCategory!
                                                    .subCategories
                                                    .length +
                                                1),
                                    gridDelegate:
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 400,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      childAspectRatio: 5,
                                    ),
                                    itemBuilder: (context, index) => index == 0
                                        ? AnimationConfiguration.staggeredGrid(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            position: index,
                                            columnCount:
                                                getApproxCount(context),
                                            child: ScaleAnimation(
                                              scale: 0.5,
                                              child: FadeInAnimation(
                                                child:
                                                    addFurnitureButton(context),
                                              ),
                                            ),
                                          )
                                        : AnimationConfiguration.staggeredGrid(
                                            position: index,
                                            duration: const Duration(
                                                milliseconds: 400),
                                            columnCount:
                                                getApproxCount(context),
                                            child: ScaleAnimation(
                                              scale: 0.5,
                                              child: FadeInAnimation(
                                                child: Skeletonizer(
                                                  effect: ShimmerEffect(
                                                    baseColor: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.4),
                                                    highlightColor: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.3),
                                                  ),
                                                  enabled: state
                                                      is GetAllCategoriesLoadingState,
                                                  child: categoryCard(
                                                      index - 1, context),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Column selectBrandPopup(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Select Brand",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.close,
                  size: 28,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Transform.scale(
                        scale: 0.5,
                        child: SvgPicture.asset("assets/svgs/search_icon.svg"),
                      ),
                      hintText: "Search Brand",
                      // ignore: prefer_const_constructors
                      hintStyle:
                          TextStyle(fontSize: 14, color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            BorderSide(color: Theme.of(context).dividerColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      focusColor: AppColors.primaryColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primaryColor,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColors.backgrouGrey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        context.read<CategoryBloc>().categories[index].name,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0 ? AppColors.primaryColor : Colors.white,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => Container(
              height: 0.5,
              color: Theme.of(context).dividerColor,
            ),
            itemCount: context.read<CategoryBloc>().categories.length,
          ),
        )
      ],
    );
  }

  categoryCard(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,
        width: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  state is GetAllCategoriesLoadingState
                      ? "furniture name"
                      : context
                          .read<CategoryBloc>()
                          .currentCategory!
                          .subCategories[index]
                          .name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final TextEditingController categoryController =
                            TextEditingController(
                          text: context
                              .read<CategoryBloc>()
                              .currentCategory!
                              .subCategories[index]
                              .name,
                        );
                        final bloc = context.read<CategoryBloc>();
                        categoryPopup(context, categoryController, bloc,
                            isSubCategory: true,
                            id: context
                                .read<CategoryBloc>()
                                .currentCategory!
                                .subCategories[index]
                                .id);
                      },
                      child: Icon(
                        Icons.edit_document,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
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
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Do you want to delete ${context.read<CategoryBloc>().currentCategory!.subCategories[index].name}",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop(false);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 32, vertical: 8),
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
                                      GestureDetector(
                                        onTap: () {
                                          context.read<CategoryBloc>().add(
                                                DeleteSubCategoriesEvent(
                                                  id: context
                                                      .read<CategoryBloc>()
                                                      .currentCategory!
                                                      .subCategories[index]
                                                      .id,
                                                ),
                                              );
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 32, vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.primaryColor,
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
                                                  is DeleteSubCategoryLoadingState)
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
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  addFurnitureButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final TextEditingController categoryController =
            TextEditingController();
        final bloc = context.read<CategoryBloc>();
        categoryPopup(context, categoryController, bloc, isSubCategory: true);
      },
      child: DottedBorder(
        color: AppColors.primaryColor,
        radius: const Radius.circular(12),
        borderType: BorderType.RRect,
        dashPattern: const [10, 10],
        stackFit: StackFit.expand,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Add Sub-Category",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  getApproxCount(context) => ((MediaQuery.of(context).size.width -
              (MediaQuery.of(context).size.width > 1120
                  ? 450
                  : MediaQuery.of(context).size.width > 920
                      ? 250
                      : 0)) /
          250)
      .round();
}
