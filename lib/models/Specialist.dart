import 'package:doctor/core/strings.dart';
import 'package:file_picker/file_picker.dart';

class Specialist {
  String firstName;
  String lastName;
  String email;
  String password;
  String nationality;
  String work;
  String workAddress;
  String homeAddress;
  String bio;
  String sessionPrice;
  String sessionDuration;
  Map<String, List<String>> specialties;
  int yearOfExperience;
  String phone;

  PlatformFile? idOrPassport;
  PlatformFile? resume;
  PlatformFile? certificates;
  PlatformFile? ministryLicense;
  PlatformFile? associationMembership;

  Specialist({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.nationality,
    required this.work,
    required this.workAddress,
    required this.homeAddress,
    required this.bio,
    required this.sessionPrice,
    required this.sessionDuration,
    required this.specialties,
    required this.yearOfExperience,
    required this.phone,
    this.idOrPassport,
    this.resume,
    this.certificates,
    this.ministryLicense,
    this.associationMembership,
  });

  Specialist.withoutSpecialty({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.nationality,
    required this.work,
    required this.workAddress,
    required this.yearOfExperience,
    required this.homeAddress,
    required this.bio,
    required this.phone,
    required this.sessionPrice,
    required this.sessionDuration,
    this.idOrPassport,
    this.resume,
    this.certificates,
    this.ministryLicense,
    this.associationMembership,
  }) : specialties = {};

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return Specialist(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      nationality: json['nationality'] ?? '',
      work: json['work'] ?? '',
      workAddress: json['workAddress'] ?? '',
      homeAddress: json['homeAddress'] ?? '',
      bio: json['bio'] ?? '',
      sessionPrice: json['sessionPrice'] ?? '',
      sessionDuration: json['sessionDuration'] ?? '',
      specialties: json['specialties'] is Map
          ? Map<String, List<String>>.from(
              (json['specialties'] as Map).map(
                (key, value) => MapEntry(key, List<String>.from(value)),
              ),
            )
          : {},
      phone: json['phone'] ?? '',
      yearOfExperience: json['yearsExperience'] ?? 0,
      idOrPassport: json['idOrPassport'] != null
          ? PlatformFile(path: json['idOrPassport'], name: '', size: 0)
          : null,
      resume: json['resume'] != null
          ? PlatformFile(path: json['resume'], name: '', size: 0)
          : null,
      certificates: json['certificates'] != null
          ? PlatformFile(path: json['certificates'], name: '', size: 0)
          : null,
      ministryLicense: json['ministryLicense'] != null
          ? PlatformFile(path: json['ministryLicense'], name: '', size: 0)
          : null,
      associationMembership: json['associationMembership'] != null
          ? PlatformFile(path: json['associationMembership'], name: '', size: 0)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'nationality': nationality,
      'work': work,
      'workAddress': workAddress,
      'homeAddress': homeAddress,
      'bio': bio,
      'yearsExperience': yearOfExperience,
      'sessionPrice': sessionPrice,
      'sessionDuration': sessionDuration,
      'specialties': specialties,
      'idOrPassport': idOrPassport?.path,
      'resume': resume?.path,
      'certificates': certificates?.path,
      'ministryLicense': ministryLicense?.path,
      'associationMembership': associationMembership?.path,
    };
  }

  List<String> getSpecialtiesAsKeyValuePairs() {
    List<String> result = [];

    specialties.forEach((key, values) {
      for (var value in values) {
        String translatedValue = arabicMapForDoctorRegistration[value] ?? value;
        String mapKey = 'specialties[${smallNoSpace(key)}][]';

        result.add('$mapKey=$translatedValue');
      }
    });

    return result;
  }

  String smallNoSpace(String value) {
    var words = value.split(' ');

    if (words.length > 1) {
      value =
          '${words[0].toLowerCase()}${words[1].substring(0, 1).toUpperCase()}${words[1].substring(1)}';
    } else {
      value = words[0].toLowerCase();
    }
    return value;
  }
}
