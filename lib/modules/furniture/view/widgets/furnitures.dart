import 'dart:math';

import 'package:anakallumkal_app/api/api_urls.dart';
import 'package:anakallumkal_app/modules/furniture/bloc/furniture_bloc.dart';
import 'package:anakallumkal_app/modules/furniture/model/brand_model.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:anakallumkal_app/utils/app_common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Furnitures extends StatefulWidget {
  final List<BrandModel> brands;

  final dynamic updateType;
  final bool isLoading;
  const Furnitures({
    super.key,
    required this.brands,
    required this.updateType,
    required this.isLoading,
  });

  @override
  State<Furnitures> createState() => _FurnituresState();
}

class _FurnituresState extends State<Furnitures> {
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
      child: Padding(
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
                    "Manage Furnitures",
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
                            () {
                              context
                                  .read<FurnitureBloc>()
                                  .brandFurnitures
                                  .remove(context
                                      .read<FurnitureBloc>()
                                      .currentBrand
                                      .id);
                              context.read<FurnitureBloc>().add(
                                    GetAllFurnituresEvent(
                                      brand: context
                                          .read<FurnitureBloc>()
                                          .currentBrand,
                                      query: value.toLowerCase().trim(),
                                    ),
                                  );
                            },
                          );
                        },
                        decoration: InputDecoration(
                          prefixIcon: Transform.scale(
                            scale: 0.5,
                            child:
                                SvgPicture.asset("assets/svgs/search_icon.svg"),
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
                    const SizedBox(width: 24),
                    GestureDetector(
                      onTap: () {
                        context.read<FurnitureBloc>().add(
                              ExportFurnituresEvent(),
                            );
                      },
                      child: Container(
                        height: 40,
                        width:
                            MediaQuery.of(context).size.width > 670 ? 150 : 75,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                            ),
                            if (MediaQuery.of(context).size.width > 670)
                              const SizedBox(width: 8),
                            if (MediaQuery.of(context).size.width > 670)
                              const Text(
                                "Export",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: widget.brands.isEmpty && !widget.isLoading
                  ? Center(
                      child: Text(
                        "No Furnitures available",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context).size.width > 920 ? 24 : 0,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: MediaQuery.of(context).size.width > 920
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
                                            child: selectBrandPopup(context),
                                          ),
                                        );
                                      },
                                child: Row(
                                  children: [
                                    Skeletonizer(
                                      effect: ShimmerEffect(
                                        baseColor: AppColors.primaryColor
                                            .withOpacity(0.4),
                                        highlightColor: AppColors.primaryColor
                                            .withOpacity(0.3),
                                      ),
                                      enabled: widget.isLoading,
                                      child: !widget.isLoading &&
                                              context
                                                      .read<FurnitureBloc>()
                                                      .currentBrand
                                                      .name !=
                                                  ""
                                          ? BlocBuilder<FurnitureBloc,
                                              FurnitureState>(
                                              builder: (context, state) {
                                                return Text(
                                                  "${context.read<FurnitureBloc>().currentBrand.name} ( ${(context.read<FurnitureBloc>().brandFurnitures[context.read<FurnitureBloc>().currentBrand.id]?.length ?? 0) - 1} )",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                );
                                              },
                                            )
                                          : widget.isLoading
                                              ? const Text(
                                                  "Brand Name",
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500,
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
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Transform.rotate(
                                      angle: 90 * pi / 180,
                                      child: SvgPicture.asset(
                                        "assets/svgs/filter_icon.svg",
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).iconTheme.color!,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Filter",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: AnimationLimiter(
                              child: GridView.builder(
                                itemCount: widget.isLoading
                                    ? 31
                                    : (context
                                                    .read<FurnitureBloc>()
                                                    .brandFurnitures[
                                                context
                                                    .read<FurnitureBloc>()
                                                    .currentBrand
                                                    .id] ??
                                            [])
                                        .length,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 250,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                                itemBuilder: (context, index) => index == 0
                                    ? AnimationConfiguration.staggeredGrid(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        position: index,
                                        columnCount: getApproxCount(context),
                                        child: ScaleAnimation(
                                          scale: 0.5,
                                          child: FadeInAnimation(
                                            child: addFurnitureButton(context),
                                          ),
                                        ),
                                      )
                                    : AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 400),
                                        columnCount: getApproxCount(context),
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
                                              enabled: widget.isLoading,
                                              child:
                                                  furnitureCard(index, context),
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
                        "${widget.brands[index].name} (${widget.brands[index].count})",
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
            itemCount: widget.brands.length,
          ),
        )
      ],
    );
  }

  furnitureCard(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.updateType(
            "furniture",
            context.read<FurnitureBloc>().brandFurnitures[
                context.read<FurnitureBloc>().currentBrand.id]![index]);
      },
      child: Container(
        height: 100,
        width: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Skeleton.leaf(
              enabled: widget.isLoading,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: widget.isLoading
                      ? Colors.grey
                      : AppColors.primaryColor.withOpacity(0.4),
                  image: widget.isLoading
                      ? null
                      : DecorationImage(
                          image: CachedNetworkImageProvider(
                            ApiUrls.mediaUrl +
                                context
                                    .read<FurnitureBloc>()
                                    .brandFurnitures[context
                                        .read<FurnitureBloc>()
                                        .currentBrand
                                        .id]![index]
                                    .image,
                          ),
                        ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.isLoading
                            ? "category"
                            : context
                                .read<FurnitureBloc>()
                                .brandFurnitures[context
                                    .read<FurnitureBloc>()
                                    .currentBrand
                                    .id]![index]
                                .category
                                .name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.isLoading
                          ? "J80"
                          : "\u20B9 ${context.read<FurnitureBloc>().brandFurnitures[context.read<FurnitureBloc>().currentBrand.id]![index].price}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Text(
                  widget.isLoading
                      ? "furniture name"
                      : context
                          .read<FurnitureBloc>()
                          .brandFurnitures[context
                              .read<FurnitureBloc>()
                              .currentBrand
                              .id]![index]
                          .name,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  addFurnitureButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.updateType("furniture");
      },
      child: DottedBorder(
        color: AppColors.primaryColor,
        radius: const Radius.circular(12),
        borderType: BorderType.RRect,
        dashPattern: const [10, 10],
        stackFit: StackFit.expand,
        child: SizedBox(
          height: 100,
          child: Column(
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
              const SizedBox(height: 8),
              Text(
                "Add New Furniture to\n${context.read<FurnitureBloc>().currentBrand.name}",
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
