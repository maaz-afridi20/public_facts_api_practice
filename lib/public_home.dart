import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:public_facts_api_practice/public_home_model.dart';

class PublicHome extends StatefulWidget {
  PublicHome({Key? key}) : super(key: key);

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  Future<Publicapi?> fetchData() async {
    String myUrl = "https://api.publicapis.org/entries";
    http.Response response = await http.get(Uri.parse(myUrl));
    var jsonDecoded = await json.decode(response.body);

    Publicapi publicapi = Publicapi.fromJson(jsonDecoded);

    return publicapi;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xfffed766),
          title: const Text('Public Api'),
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: fetchData(),
            builder: (context, AsyncSnapshot<Publicapi?> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final result = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Text('Number of entries : '),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Card(
                              color: Colors.amber.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text('${snapshot.data!.count}'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Text('Name of Api : '),
                        ...List.generate(1, (index) {
                          return Container(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                    '${snapshot.data!.entries[index].api}'),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Text('Usage of Api : '),
                        ...List.generate(
                          1,
                          (index) {
                            return Container(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                      '${result.entries[index].description}'),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Text('Category : '),
                        ...List.generate(
                          1,
                          (index) {
                            return Container(
                              child: Card(
                                child: Text(
                                    '${snapshot.data!.entries[index].category}'),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const ListTile(
                    tileColor: Colors.green,
                    title: Text('Another details'),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        ...List.generate(
                          1,
                          (index) {
                            return Container(
                              child: Card(
                                child: Text('${result.entries[9].api}'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                    1,
                    (index) {
                      return Text('${result.entries[8].description}');
                    },
                  )
                ],
              );
            },
          ),
        ));
  }
}


 // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Card(
                  //         color: Colors.amber.shade200,
                  //         child: Padding(
                  //           padding:  EdgeInsets.all(20.0),
                  //           // child: Text('${snapshot.data!.entries[index].}'),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // this is use to print whole array => length snapshot.data!.entries.length