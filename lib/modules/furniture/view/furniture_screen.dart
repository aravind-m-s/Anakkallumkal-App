import 'package:anakallumkal_app/common/widgets/app_bar.dart';
import 'package:anakallumkal_app/modules/furniture/bloc/furniture_bloc.dart';
import 'package:anakallumkal_app/modules/furniture/model/brand_model.dart';
import 'package:anakallumkal_app/modules/furniture/model/furniture_model.dart';
import 'package:anakallumkal_app/modules/furniture/model/shop_model.dart';
import 'package:anakallumkal_app/modules/furniture/view/widgets/add_brand_screen.dart';
import 'package:anakallumkal_app/modules/furniture/view/widgets/add_furniture_screen.dart';
import 'package:anakallumkal_app/modules/furniture/view/widgets/brands.dart';
import 'package:anakallumkal_app/modules/furniture/view/widgets/furnitures.dart';
import 'package:anakallumkal_app/common/widgets/sidebar.dart';
import 'package:anakallumkal_app/utils/app_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FurnitureScreen extends StatefulWidget {
  const FurnitureScreen({super.key});

  @override
  State<FurnitureScreen> createState() => _FurnitureScreenState();
}

class _FurnitureScreenState extends State<FurnitureScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<BrandModel> brands = [];
  List<ShopModel> shops = [];

  String type = "";

  dynamic editItem;

  late FurnitureBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FurnitureBloc()..add(GetAllBrandsEvent()),
      child: SafeArea(
        child: BlocConsumer<FurnitureBloc, FurnitureState>(
            listener: (context, state) {
          if (state is GetAllBrandsSuccessState) {
            brands = state.brands;
            shops = state.shops;
          } else if (state is GetAllFurnituresSuccessState) {
            bloc.add(GetAllCategoriesEvent());

            if (bloc.brandFurnitures[state.brand.id]!.isEmpty) {
              bloc.brandFurnitures[state.brand.id] = [
                FurnitureModel(
                  id: '',
                  image: '',
                  name: '',
                  price: 0,
                  productNo: '',
                  rows: 0,
                  stock: 0,
                  category: FurnitureCategoryModel(
                    id: 'id',
                    name: 'name',
                    category: Category(id: "", name: ""),
                  ),
                ),
              ];
            } else if (bloc
                .brandFurnitures[state.brand.id]!.first.id.isNotEmpty) {
              bloc.brandFurnitures[state.brand.id]!.insert(
                0,
                FurnitureModel(
                  id: '',
                  image: '',
                  name: '',
                  price: 0,
                  productNo: '',
                  rows: 0,
                  stock: 0,
                  category: FurnitureCategoryModel(
                    id: 'id',
                    name: 'name',
                    category: Category(id: "", name: ""),
                  ),
                ),
              );
            }
          } else if (state is CreateFurnitureSuccessState) {
            Navigator.pop(context);
            bloc.brandFurnitures[state.brandId]!.insert(1, state.furniture);
            final index = brands
                .indexWhere((element) => element.id == bloc.currentBrand.id);

            if (index != -1) {
              brands[index].count += 1;
            }
          } else if (state is CreateBrandSuccessState) {
            Navigator.pop(context);
            bloc.add(GetAllFurnituresEvent(brand: state.brand));
            brands.insert(0, state.brand);
          } else if (state is UpdateBrandSuccessState) {
            Navigator.pop(context);

            final index = brands.indexWhere(
              (element) => element.id == state.brand.id,
            );
            brands[index] = state.brand;
          } else if (state is UpdateFurnitureSuccessState) {
            Navigator.pop(context);
            final index = bloc.brandFurnitures[state.brandId]!.indexWhere(
              (element) => element.id == state.furniture.id,
            );
            bloc.brandFurnitures[state.brandId]![index] = state.furniture;
          } else if (state is DeleteBrandLoadingState) {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DeleteFurnitureLoadingState) {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DeleteFurnitureSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            bloc.brandFurnitures[bloc.currentBrand.id] =
                bloc.brandFurnitures[bloc.currentBrand.id]!
                    .where(
                      (element) => element.id != state.id,
                    )
                    .toList();

            final index = brands.indexWhere(
              (element) => element.id == bloc.currentBrand.id,
            );

            bloc.currentBrand.count =
                bloc.brandFurnitures[bloc.currentBrand.id]!.length;
            brands[index] = bloc.currentBrand..count -= 1;
          } else if (state is DeleteBrandSuccessState) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            if (brands.first.id == state.id) {
              if (brands.length > 1) {
                bloc.currentBrand = brands[1];
                bloc.add(GetAllFurnituresEvent(brand: bloc.currentBrand));
              } else {
                bloc.add(GetAllBrandsEvent());
              }
            }
            brands.removeWhere(
              (element) => element.id == state.id,
            );
          } else if (state is ExportFurnitureSuccessState) {
            launchUrlString(state.stockBookExcel.startsWith("http")
                ? state.stockBookExcel
                : "https://${state.stockBookExcel}");
            launchUrlString(state.brouchureExcel.startsWith("http")
                ? state.brouchureExcel
                : "https://${state.brouchureExcel}");
          } else if (state is CreateBrandErrorState) {
            AppCommon.messageDialog(state.message);
          } else if (state is CreateFurnitureErrorState) {
            AppCommon.messageDialog(state.message);
          } else if (state is UpdateBrandErrorState) {
            AppCommon.messageDialog(state.message);
          } else if (state is UpdateFurnitureErrorState) {
            AppCommon.messageDialog(state.message);
          } else if (state is GetAllBrandsErrorState) {
            AppCommon.messageDialog(state.message);
          } else if (state is GetAllFurnituresErrorState) {
            AppCommon.messageDialog(state.message);
          }
        }, builder: (context, state) {
          bloc = context.read<FurnitureBloc>();
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
                if (MediaQuery.of(context).size.width > 1120) const Sidebar(),
                if (MediaQuery.of(context).size.width > 920)
                  Brands(
                    brands: brands,
                    isLoading: bloc.isBrandLoading || state is FurnitureInitial,
                    updateType: updateType,
                  ),
                Furnitures(
                  brands: brands,
                  updateType: updateType,
                  isLoading: bloc.isFurnituresLoading ||
                      bloc.isBrandLoading ||
                      bloc.isCategoriesLoading ||
                      state is FurnitureInitial,
                )
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
      bloc.selectedCategory == null;
      bloc.categoryId == "";
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
