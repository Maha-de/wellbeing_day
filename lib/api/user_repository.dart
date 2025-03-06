
import '../models/specialist_model.dart';
import 'api_consumer.dart';
import 'either.dart';
import 'end_points.dart';



class UserRepository {
  final ApiConsumer api;

  UserRepository({required this.api});

  Future<Either<String, List<Specialists>>> getSpecialists() async {
    try {
      // Make your API call here to fetch the list of specialists
      final response = await api.get(
        EndPoint.getAllSpecialist,
        data: {},
      );

      if (response['message'] =="Specialists fetched successfully." ) {
        // Parse the entire response to get the list of specialists
        SpecialistsResponse specialistModel = SpecialistsResponse.fromJson(response);

        // Return the list of specialists from the parsed response
        return Right(specialistModel.items ?? []);
      } else {
        return Left('Failed to load specialists');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }
}

