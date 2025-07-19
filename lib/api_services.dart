import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:workout_http_methods/dog_model.dart';

Future<Dogmodel> getDog() async {
  final response = await http.get(
    Uri.parse('https://dog.ceo/api/breed/beagle/images'),
  );
  if (response.statusCode == 200) {
    return Dogmodel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("could not fetch data");
  }
}
