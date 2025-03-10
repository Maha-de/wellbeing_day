// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class SessionType {
  String get sessionType;
  bool get isPaid;
}

class InstantSession extends SessionType {
  String description;
  InstantSession({
    required this.description,
  });
  @override
  String get sessionType => "Instant Session";

  @override
  bool get isPaid => false;
}

class FreeSession extends SessionType {
  String description;
  FreeSession({
    required this.description,
  });
  @override
  String get sessionType => "Free Session";
  @override
  bool get isPaid => false;
}

class RegularSession extends SessionType {
  @override
  String get sessionType => "Regular Session";
  @override
  bool get isPaid => true;
}

class GruopTherapSession extends SessionType {
   List<String>? problems;
   GruopTherapSession({
     required this.problems,
   });
  @override
  String get sessionType => "Group Therapy";
  @override
  bool get isPaid => true;
}
