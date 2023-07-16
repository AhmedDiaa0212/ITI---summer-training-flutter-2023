import 'package:flutter/material.dart';
import 'package:newapp/models/todos_model.dart';
import '../../services/todos_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TodosModel> todos = [];
  bool isLoading = true;

  getTodos() async {
    todos = await TodosService().getTodosData();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(todos[index].id.toString()),
                title: Text(todos[index].title ?? "--"),
                subtitle: Text(todos[index].completed.toString()),
                trailing: const Icon(Icons.list),
                tileColor: const Color.fromARGB(255, 229, 243, 250),
                iconColor: Colors.blue,
              );
            },
          );
  }
}
