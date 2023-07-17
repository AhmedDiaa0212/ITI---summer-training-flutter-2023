import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newapp/views/todos/todos_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosCubit(),
      child: BlocConsumer<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is TodosLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodosSuccess) {
            return ListView.builder(
              itemCount: context.watch<TodosCubit>().todos.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                      context.watch<TodosCubit>().todos[index].id.toString()),
                  title: Text(
                      context.watch<TodosCubit>().todos[index].title ?? "--"),
                  subtitle: Text(context
                      .watch<TodosCubit>()
                      .todos[index]
                      .completed
                      .toString()),
                  trailing: const Icon(Icons.list),
                  tileColor: const Color.fromARGB(255, 229, 243, 250),
                  iconColor: Colors.blue,
                );
              },
            );
          } else {
            return const Center(
              child: Text("There is an error on this screen"),
            );
          }
        },
        listener: (context, state) {
          if (state is TodosError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Hello we have error"),
            ));
            print("Hello");
          }
        },
      ),
    );
  }
}
