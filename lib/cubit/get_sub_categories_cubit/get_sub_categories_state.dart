import 'package:equatable/equatable.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/sub_categories_model.dart';


// Base state class
abstract class SubCategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class SubCategoriesInitial extends SubCategoriesState {}

// Loading state
class SubCategoriesLoading extends SubCategoriesState {}

// Success state
class SubCategoriesSuccess extends SubCategoriesState {
  final String message;
  final List<GetSubCategoriesModel> subCategories;

  SubCategoriesSuccess(this.message, this.subCategories);

  @override
  List<Object?> get props => [message, subCategories];
}

// Failure state
class SubCategoriesFailure extends SubCategoriesState {
  final String errMessage;

  SubCategoriesFailure(String s, {required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
