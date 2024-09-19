import 'package:anakallumkal_app/modules/category/bloc/category_bloc.dart';
import 'package:anakallumkal_app/modules/category/view/widgets/dialog_widget.dart';
import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:anakallumkal_app/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Categories extends StatelessWidget {
  const Categories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
      ),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          final bool isLoading =
              state is GetAllCategoriesLoadingState || state is CategoryInitial;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (context.read<CategoryBloc>().categories.isEmpty && !isLoading)
                Expanded(
                  child: Center(
                    child: Text(
                      "No categories available",
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
                                  onLongPress: () {},
                                  onTap: () {
                                    context
                                            .read<CategoryBloc>()
                                            .currentCategory =
                                        context
                                            .read<CategoryBloc>()
                                            .categories[index];
                                    context
                                        .read<CategoryBloc>()
                                        .add(UpdateStateEvent());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      isLoading
                                          ? "Brand Name"
                                          : context
                                              .read<CategoryBloc>()
                                              .categories[index]
                                              .name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        itemCount: isLoading
                            ? 20
                            : context.read<CategoryBloc>().categories.length,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    final TextEditingController categoryController =
                        TextEditingController();
                    final bloc = context.read<CategoryBloc>();
                    categoryPopup(context, categoryController, bloc);
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
                          "Add New Category",
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
          );
        },
      ),
    );
  }
}
