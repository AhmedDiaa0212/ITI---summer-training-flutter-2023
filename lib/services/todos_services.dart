import 'package:dio/dio.dart';

import '../models/todos_model.dart';

class TodosService {
  String url = "https://jsonplaceholder.typicode.com/todos";

  Future<List<TodosModel>> getTodosData() async {
    List<TodosModel> todosList = [];
    final dio = Dio();
    final response = await dio.get(url);
    var data = response.data;
    data.forEach((jsonElement) {
      TodosModel todo = TodosModel.fromJson(jsonElement);
      todosList.add(todo);
    });
    return todosList;
  }
}
