import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workout_http_methods/api_services.dart';
import 'package:workout_http_methods/dog_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Dogmodel>? get;
  @override
  void initState() {
    super.initState();
    get = getDog();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Dogmodel>(
            future: get,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                List dogRange = snapshot.data!.message.sublist(0, 10);
                int dogRangelen = dogRange.length;
                return ListView.builder(
                  itemCount: dogRangelen,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Card(
                          margin: const EdgeInsets.all(8.0),
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.network(snapshot.data!.message[index]),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                print("Error: ${snapshot.error}");
                throw Exception("Could not fetch data");
              }
            },
          ),
        ),
      ),
    );
  }
}
