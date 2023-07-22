import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectCollection extends StatefulWidget {
  const ProjectCollection({super.key});

  @override
  State<ProjectCollection> createState() => _ProjectCollectionState();
}

class _ProjectCollectionState extends State<ProjectCollection> {
  CollectionReference projectDocument =
      FirebaseFirestore.instance.collection('project');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<QuerySnapshot<Object?>>(
          future: projectDocument.get(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.hasData == false && snapshot.data == null) {
              return const Text("Error getting documents");
            }
            print(snapshot.connectionState.toString());
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    "Project title: ${snapshot.data!.docs[index]['name']} Description :${snapshot.data!.docs[index]['description']} ",
                  );
                },
              );
            }
            return const Text("loading");
          },
        ));
  }
}
