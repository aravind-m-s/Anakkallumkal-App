part of 'furniture_bloc.dart';

sealed class FurnitureState extends Equatable {
  const FurnitureState();

  @override
  List<Object> get props => [];
}

final class FurnitureInitial extends FurnitureState {}

final class GetAllBrandsLoadingState extends FurnitureState {}

final class GetAllBrandsSuccessState extends FurnitureState {
  final List<BrandModel> brands;
  final List<ShopModel> shops;

  const GetAllBrandsSuccessState({required this.brands, required this.shops});

  @override
  List<Object> get props => [brands, shops];
}

final class GetAllBrandsErrorState extends FurnitureState {
  final String message;

  const GetAllBrandsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetAllFurnituresLoadingState extends FurnitureState {}

final class GetAllFurnituresSuccessState extends FurnitureState {
  final BrandModel brand;

  const GetAllFurnituresSuccessState({required this.brand});

  @override
  List<Object> get props => [brand];
}

final class GetAllFurnituresErrorState extends FurnitureState {
  final String message;

  const GetAllFurnituresErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateStateState extends FurnitureState {
  final DateTime dateTime;

  const UpdateStateState({required this.dateTime});

  @override
  List<Object> get props => [dateTime];
}

final class CreateFurnitureLoadingState extends FurnitureState {}

final class CreateFurnitureSuccessState extends FurnitureState {
  final FurnitureModel furniture;
  final String brandId;

  const CreateFurnitureSuccessState({
    required this.furniture,
    required this.brandId,
  });

  @override
  List<Object> get props => [furniture];
}

final class CreateFurnitureErrorState extends FurnitureState {
  final String message;

  const CreateFurnitureErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class CreateBrandLoadingState extends FurnitureState {}

final class CreateBrandSuccessState extends FurnitureState {
  final BrandModel brand;

  const CreateBrandSuccessState({required this.brand});

  @override
  List<Object> get props => [brand];
}

final class CreateBrandErrorState extends FurnitureState {
  final String message;

  const CreateBrandErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateFurnitureLoadingState extends FurnitureState {}

final class UpdateFurnitureSuccessState extends FurnitureState {
  final FurnitureModel furniture;
  final String brandId;

  const UpdateFurnitureSuccessState({
    required this.furniture,
    required this.brandId,
  });

  @override
  List<Object> get props => [furniture];
}

final class UpdateFurnitureErrorState extends FurnitureState {
  final String message;

  const UpdateFurnitureErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class UpdateBrandLoadingState extends FurnitureState {}

final class UpdateBrandSuccessState extends FurnitureState {
  final BrandModel brand;

  const UpdateBrandSuccessState({required this.brand});

  @override
  List<Object> get props => [brand];
}

final class UpdateBrandErrorState extends FurnitureState {
  final String message;

  const UpdateBrandErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeleteBrandLoadingState extends FurnitureState {}

final class DeleteBrandSuccessState extends FurnitureState {
  final String id;

  const DeleteBrandSuccessState({required this.id});
  @override
  List<Object> get props => [id];
}

final class DeleteBrandErrorState extends FurnitureState {
  final String message;

  const DeleteBrandErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeleteFurnitureLoadingState extends FurnitureState {}

final class DeleteFurnitureSuccessState extends FurnitureState {
  final String id;

  const DeleteFurnitureSuccessState({required this.id});
  @override
  List<Object> get props => [id];
}

final class DeleteFurnitureErrorState extends FurnitureState {
  final String message;

  const DeleteFurnitureErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class ExportFurnitureLoadingState extends FurnitureState {}

final class ExportFurnitureSuccessState extends FurnitureState {
  final String brouchureExcel;
  final String stockBookExcel;

  const ExportFurnitureSuccessState(
      {required this.brouchureExcel, required this.stockBookExcel});

  @override
  List<Object> get props => [brouchureExcel, stockBookExcel];
}

final class ExportFurnitureErrorState extends FurnitureState {
  final String message;

  const ExportFurnitureErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

final class GetAllCategoriesLoadingState extends FurnitureState {}

final class GetAllCategoriesSuccessState extends FurnitureState {
  @override
  List<Object> get props => [];
}

final class GetAllCategoriesErrorState extends FurnitureState {
  final String message;

  const GetAllCategoriesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
