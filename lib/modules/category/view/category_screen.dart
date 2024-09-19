import 'package:anakallumkal_app/common/widgets/app_bar.dart';
import 'package:anakallumkal_app/modules/category/bloc/category_bloc.dart';
import 'package:anakallumkal_app/modules/category/view/widgets/categories.dart';
import 'package:anakallumkal_app/modules/category/view/widgets/sub_category.dart';
import 'package:anakallumkal_app/modules/furniture/model/brand_model.dart';
import 'package:anakallumkal_app/modules/furniture/model/shop_model.dart';
import 'package:anakallumkal_app/modules/furniture/view/widgets/add_brand_screen.dart';
import 'package:anakallumkal_app/modules/furniture/view/widgets/add_furniture_screen.dart';
import 'package:anakallumkal_app/common/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<BrandModel> brands = [];
  List<ShopModel> shops = [];

  String type = "";

  dynamic editItem;

  late CategoryBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(GetAllCategoriesEvent()),
      child: SafeArea(
        child: BlocConsumer<CategoryBloc, CategoryState>(
            listener: (context, state) {},
            builder: (context, state) {
              bloc = context.read<CategoryBloc>();
              return Scaffold(
                key: scaffoldKey,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                drawer: MediaQuery.of(context).size.width <= 1120
                    ? const Sidebar()
                    : null,
                endDrawer: type.isEmpty
                    ? null
                    : type == "brand"
                        ? AddBrandScreen(
                            shops: shops,
                            editItem: editItem,
                          )
                        : AddFurnitureScreen(
                            editItem: editItem,
                          ),
                appBar: customAppbar(context, scaffoldKey),
                body: Row(
                  children: [
                    if (MediaQuery.of(context).size.width > 1120)
                      const Sidebar(),
                    if (MediaQuery.of(context).size.width > 920) const Categories(),
                    const SubCategory(),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void updateType(String type, [dynamic item]) async {
    this.type = type;
    editItem = null;
    if (type == "furniture") {
      if (item != null) {
        editItem = item;
      }
      bloc.add(UpdateStateEvent());
      await Future.delayed(const Duration(milliseconds: 200));
      scaffoldKey.currentState!.openEndDrawer();
    } else if (type == "brand") {
      if (item != null) {
        editItem = item;
      }
      bloc.add(UpdateStateEvent());
      await Future.delayed(const Duration(milliseconds: 200));
      scaffoldKey.currentState!.openEndDrawer();
    }
  }
}
