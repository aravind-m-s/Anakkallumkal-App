import 'dart:convert';
import 'dart:developer';

import 'package:anakallumkal_app/api/api_provider.dart';
import 'package:anakallumkal_app/modules/furniture/model/brand_model.dart';
import 'package:anakallumkal_app/modules/furniture/model/category_model.dart';
import 'package:anakallumkal_app/modules/furniture/model/furniture_model.dart';
import 'package:anakallumkal_app/modules/furniture/model/shop_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'furniture_event.dart';
part 'furniture_state.dart';

class FurnitureBloc extends Bloc<FurnitureEvent, FurnitureState> {
  bool isBrandLoading = false;
  bool isFurnituresLoading = false;
  bool isCategoriesLoading = false;

  final Map<String, List<FurnitureModel>> brandFurnitures = {};

  BrandModel currentBrand = BrandModel(
    id: '',
    name: '',
    image: '',
    shop: ShopModel(id: '', name: '', place: '', image: ''),
    count: 0,
  );

  final List<CategoryModel> categories = [];

  CategoryModel? selectedCategory;
  String categoryId = '';

  FurnitureBloc() : super(FurnitureInitial()) {
    on<GetAllBrandsEvent>(getAllBrandsBloc);
    on<GetAllCategoriesEvent>(getAllCategoriesBloc);
    on<GetAllFurnituresEvent>(getAllFurnituresBloc);
    on<CreateFurnitureEvent>(createFurnitureBloc);
    on<CreateBrandEvent>(createBrandBloc);
    on<UpdateFurnitureEvent>(updateFurnitureBloc);
    on<UpdateBrandEvent>(updateBrandBloc);
    on<DeleteBrandEvent>(deleteBrandBloc);
    on<DeleteFurnitureEvent>(deleteFurnitureBloc);
    on<ExportFurnituresEvent>(exportFurnitureBloc);
    on<UpdateStateEvent>(
        (_, emit) => emit(UpdateStateState(dateTime: DateTime.now())));
  }

  getAllBrandsBloc(
    GetAllBrandsEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      isBrandLoading = true;
      emit(GetAllBrandsLoadingState());
      final response = await ApiProvider.getAllBrands();
      log(response.body);
      if (response.statusCode == 200) {
        final List<BrandModel> brands = [];
        final List<ShopModel> shops = [];

        if (jsonDecode(response.body)['brands'].isNotEmpty) {
          jsonDecode(response.body)['brands'].forEach(
            (element) => brands.add(
              BrandModel.fromJson(element),
            ),
          );
        }

        jsonDecode(response.body)['shops'].forEach(
          (element) => shops.add(
            ShopModel.fromJson(element),
          ),
        );

        if (brands.isNotEmpty) {
          currentBrand = brands.first;
          add(GetAllFurnituresEvent(brand: currentBrand));
        }

        emit(GetAllBrandsSuccessState(brands: brands, shops: shops));
      } else {
        emit(
          GetAllBrandsErrorState(
            message: jsonDecode(response.body)['message'] ??
                "Something went wrong, Please try again later",
          ),
        );
      }
    } catch (e) {
      emit(const GetAllBrandsErrorState(message: "Internal Error Occured"));
    }
    isBrandLoading = false;
  }

  getAllCategoriesBloc(
    GetAllCategoriesEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      isCategoriesLoading = true;
      emit(GetAllCategoriesLoadingState());
      if (categories.isNotEmpty) {
        emit(GetAllCategoriesSuccessState());
        return;
      }
      final response = await ApiProvider.getAllCategories();
      if (response.statusCode == 200) {
        if (response.body != "null" && response.body != "[]") {
          categories.clear();
          jsonDecode(response.body).forEach(
            (element) => categories.add(
              CategoryModel.fromJson(element),
            ),
          );
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
    isCategoriesLoading = false;
  }

  getAllFurnituresBloc(
    GetAllFurnituresEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      isFurnituresLoading = true;
      currentBrand = event.brand;

      emit(GetAllFurnituresLoadingState());
      if (brandFurnitures[event.brand.id] != null) {
        isFurnituresLoading = false;
        emit(
          GetAllFurnituresSuccessState(
            brand: event.brand,
          ),
        );
        return;
      }
      final response =
          await ApiProvider.getAllFurnitures(event.brand.id, event.query);
      if (response.statusCode == 200) {
        final List<FurnitureModel> furnitures = [];
        if (response.body == "[]") {
          isFurnituresLoading = false;
          brandFurnitures[event.brand.id] = [];
          return emit(
            GetAllFurnituresSuccessState(
              brand: event.brand,
            ),
          );
        }
        jsonDecode(response.body).forEach(
          (element) => furnitures.add(
            FurnitureModel.fromJson(element),
          ),
        );
        log(response.body);
        brandFurnitures[event.brand.id] = furnitures;
        emit(
          GetAllFurnituresSuccessState(
            brand: event.brand,
          ),
        );
      } else {
        emit(
          GetAllFurnituresErrorState(
            message: jsonDecode(response.body)['message'] ??
                "Something went wrong, Please try again later",
          ),
        );
      }
    } catch (e) {
      emit(const GetAllFurnituresErrorState(message: "Internal Error Occured"));
    }
    isFurnituresLoading = false;
  }

  createFurnitureBloc(
    CreateFurnitureEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      emit(CreateFurnitureLoadingState());
      final response = await ApiProvider.createFurniture(
        event.name,
        event.productNo,
        event.stock,
        event.price,
        event.brand,
        event.image,
        event.categoryId,
        event.rows,
      );
      log(response.statusCode.toString());
      if (response.statusCode == 201) {
        emit(
          CreateFurnitureSuccessState(
            brandId: event.brand,
            furniture: FurnitureModel.fromJson(
              jsonDecode(response.body),
            ),
          ),
        );
      } else {
        emit(CreateFurnitureErrorState(
            message: jsonDecode(response.body)['message'] ?? ""));
      }
    } catch (e) {
      emit(const CreateFurnitureErrorState(message: "Internal Error Occured"));
    }
  }

  createBrandBloc(
    CreateBrandEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      emit(CreateBrandLoadingState());
      final response = await ApiProvider.createBrand(
        event.name,
        event.shop,
        event.image,
      );
      if (response.statusCode == 201) {
        emit(
          CreateBrandSuccessState(
            brand: BrandModel.fromJson(
              jsonDecode(response.body),
            ),
          ),
        );
      } else {
        emit(CreateBrandErrorState(
            message: jsonDecode(response.body)['message'] ?? ""));
      }
    } catch (e) {
      emit(const CreateBrandErrorState(message: "Internal Error Occured"));
    }
  }

  updateFurnitureBloc(
    UpdateFurnitureEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      emit(UpdateFurnitureLoadingState());
      final response = await ApiProvider.updateFurniture(
        event.id,
        event.name,
        event.productNo,
        event.stock,
        event.price,
        event.brand,
        event.image,
        event.categoryId,
        event.rows,
      );
      if (response.statusCode == 201) {
        final furniture = FurnitureModel.fromJson(
          jsonDecode(response.body),
        );
        final subCategory = selectedCategory!.subCategories.firstWhere(
          (element) => element.id == categoryId,
        );
        furniture.category = FurnitureCategoryModel(
          id: categoryId,
          name: subCategory.name,
          category: Category(
            id: selectedCategory!.id,
            name: selectedCategory!.name,
          ),
        );
        emit(
          UpdateFurnitureSuccessState(
            brandId: event.brand,
            furniture: furniture,
          ),
        );
      } else {
        emit(UpdateFurnitureErrorState(
            message: jsonDecode(response.body)['message'] ?? ""));
      }
    } catch (e) {
      emit(const UpdateFurnitureErrorState(message: "Internal Error Occured"));
    }
  }

  updateBrandBloc(
    UpdateBrandEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      emit(UpdateBrandLoadingState());
      final response = await ApiProvider.updateBrand(
        event.id,
        event.name,
        event.shop,
        event.image,
      );
      if (response.statusCode == 201) {
        emit(
          UpdateBrandSuccessState(
            brand: BrandModel.fromJson(
              jsonDecode(response.body),
            ),
          ),
        );
      } else {
        emit(UpdateBrandErrorState(
            message: jsonDecode(response.body)['message'] ?? ""));
      }
    } catch (e) {
      emit(const UpdateBrandErrorState(message: "Internal Error Occured"));
    }
  }

  deleteBrandBloc(
    DeleteBrandEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      emit(DeleteBrandLoadingState());
      final response = await ApiProvider.deleteBrand(
        event.id,
      );
      if (response.statusCode == 200) {
        emit(
          DeleteBrandSuccessState(id: event.id),
        );
      } else {
        emit(DeleteBrandErrorState(
            message: jsonDecode(response.body)['message'] ?? ""));
      }
    } catch (e) {
      emit(const DeleteBrandErrorState(message: "Internal Error Occured"));
    }
  }

  deleteFurnitureBloc(
    DeleteFurnitureEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      emit(DeleteFurnitureLoadingState());
      final response = await ApiProvider.deleteFurniture(
        event.id,
      );
      if (response.statusCode == 200) {
        emit(
          DeleteFurnitureSuccessState(id: event.id),
        );
      } else {
        emit(DeleteFurnitureErrorState(
            message: jsonDecode(response.body)['message'] ?? ""));
      }
    } catch (e) {
      emit(const DeleteFurnitureErrorState(message: "Internal Error Occured"));
    }
  }

  exportFurnitureBloc(
    ExportFurnituresEvent event,
    Emitter<FurnitureState> emit,
  ) async {
    try {
      emit(ExportFurnitureLoadingState());
      final response = await ApiProvider.exportFurnitures(
        currentBrand.id,
      );
      if (response.statusCode == 200) {
        emit(
          ExportFurnitureSuccessState(
            brouchureExcel: jsonDecode(response.body)['brochure_excel'],
            stockBookExcel: jsonDecode(response.body)['stock_book'],
          ),
        );
      } else {
        emit(ExportFurnitureErrorState(
            message: jsonDecode(response.body)['message'] ?? ""));
      }
    } catch (e) {
      emit(const ExportFurnitureErrorState(message: "Internal Error Occured"));
    }
  }
}
