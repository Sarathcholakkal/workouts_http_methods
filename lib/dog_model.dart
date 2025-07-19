class Dogmodel {
  final List message;
  var dogRange = List;
  Dogmodel({required this.message});
  factory Dogmodel.fromJson(dynamic json) {
    return Dogmodel(message: json['message'] as List);
  }
}
