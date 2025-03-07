import 'package:equatable/equatable.dart';
import '../../models/advertisments_model.dart';
import '../../models/doctor_by_category_model.dart';
import '../../models/sub_categories_model.dart';


// Base state class
abstract class GetAllAdsState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class GetAllAdsInitial extends GetAllAdsState {}

// Loading state
class GetAllAdsLoading extends GetAllAdsState {}

// Success state
class GetAllAdsSuccess extends GetAllAdsState {
  final String message;
  final List<Adv> adv;

  GetAllAdsSuccess(this.message, this.adv);

  @override
  List<Object?> get props => [message, adv];
}

// Failure state
class GetAllAdsFailure extends GetAllAdsState {
  final String errMessage;

  GetAllAdsFailure(String s, {required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
