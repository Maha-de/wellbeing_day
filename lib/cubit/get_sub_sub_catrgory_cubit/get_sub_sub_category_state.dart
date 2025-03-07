import 'package:equatable/equatable.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/sub_categories_model.dart';


// Base state class
abstract class SubSubCategoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class SubSubCategoriesInitial extends SubSubCategoriesState {}

// Loading state
class SubSubCategoriesLoading extends SubSubCategoriesState {}

// Success state
class SubSubCategoriesSuccess extends SubSubCategoriesState {
  final String message;
  final List<String?> subCategories;

  SubSubCategoriesSuccess(this.message, this.subCategories);

  @override
  List<Object?> get props => [message, subCategories];
}

// Failure state
class SubSubCategoriesFailure extends SubSubCategoriesState {
  final String errMessage;

  SubSubCategoriesFailure(String s, {required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
