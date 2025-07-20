import 'package:flutter/material.dart';
import 'package:workout_http_methods/api_services.dart';
import 'package:workout_http_methods/dog_model.dart';
import 'package:workout_http_methods/other_method.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Dogmodel>? get;

  @override
  void initState() {
    super.initState();
    get = getDog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dog Viewer")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const OtherMethods(),
                  ),
                );
              },
              child: const Text(
                "Other Methods",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<Dogmodel>(
              future: get,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List dogRange = snapshot.data!.message.sublist(0, 10);
                  return ListView.builder(
                    itemCount: dogRange.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                snapshot.data!.message[index],
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                              ),
                            ),
                            Text(
                              index.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
