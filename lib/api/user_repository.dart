
import '../models/specialist_model.dart';
import 'api_consumer.dart';
import 'either.dart';
import 'end_points.dart';



class UserRepository {
  final ApiConsumer api;


  UserRepository({required this.api});


  Future<Either<String, List<SpecialistModel>>> getSpecialists(


      ) async {
    try {
      // Make your API call here to fetch the list of specialists
      final response = await await api.get(
        EndPoint.getAllSpecialist,
        data: {

        },
      );

      if (response['message'] == "specialists gitting successfully") {
        // Parse the response and return a list of specialists
        final List<dynamic> jsonData = response['specialists'];


        List<SpecialistModel> specialists = jsonData.map((json) =>
            SpecialistModel.fromJson(json)).toList();


        return Right(
            specialists); // Assuming you're using Either for error handling
      } else {
        return Left('Failed to load specialists');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }
}
