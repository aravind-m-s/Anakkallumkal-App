import 'package:anakallumkal_app/api/api_urls.dart';
import 'package:anakallumkal_app/modules/furniture/bloc/furniture_bloc.dart';
import 'package:anakallumkal_app/modules/furniture/model/brand_model.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Brands extends StatelessWidget {
  final bool isLoading;
  final List<BrandModel> brands;
  final dynamic updateType;
  const Brands({
    super.key,
    required this.brands,
    required this.isLoading,
    required this.updateType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (brands.isEmpty && !isLoading)
            Expanded(
              child: Center(
                child: Text(
                  "No brands available",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            )
          else
            Expanded(
              child: Skeletonizer(
                effect: ShimmerEffect(
                  baseColor: AppColors.primaryColor.withOpacity(0.4),
                  highlightColor: AppColors.primaryColor.withOpacity(0.3),
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                enabled: isLoading,
                child: AnimationLimiter(
                  child: ListView.builder(
                    itemBuilder: (context, index) =>
                        AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      child: SlideAnimation(
                        horizontalOffset: 50,
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                              left: 16,
                              right: 16,
                            ),
                            child: GestureDetector(
                              onLongPress: () {
                                updateType("brand", brands[index]);
                              },
                              onTap: () {
                                context.read<FurnitureBloc>().add(
                                      GetAllFurnituresEvent(
                                        brand: brands[index],
                                      ),
                                    );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Skeleton.leaf(
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: AppColors.backgrouGrey,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                image: isLoading
                                                    ? null
                                                    : DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                          ApiUrls.mediaUrl +
                                                              brands[index]
                                                                  .image,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              isLoading
                                                  ? "Brand Name"
                                                  : brands[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Skeleton.leaf(
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            Theme.of(context).dividerColor,
                                        child: Text(
                                          isLoading
                                              ? ""
                                              : brands[index].count.toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .color!,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: isLoading ? 20 : brands.length,
                  ),
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
                right: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: GestureDetector(
              onTap: () {
                updateType("brand");
              },
              child: Container(
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "Add New Brand",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
