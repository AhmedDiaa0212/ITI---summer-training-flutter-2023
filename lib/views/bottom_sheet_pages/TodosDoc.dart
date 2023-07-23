import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodosDoc extends StatefulWidget {
  const TodosDoc({super.key});

  @override
  State<TodosDoc> createState() => _TodosDocState();
}

class _TodosDocState extends State<TodosDoc> {
  CollectionReference todosDocument =
      FirebaseFirestore.instance.collection('Todos');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Object?>>(
      future: todosDocument.get(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        print(snapshot.connectionState.toString());

        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Table(
                  border: TableBorder.all(), // Add border to table
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                  'Task title:      ${snapshot.data!.docs[index]['title']}'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                  'Complete:      ${snapshot.data!.docs[index]['complete']} '),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Text("loading");
      },
    );
  }
}
