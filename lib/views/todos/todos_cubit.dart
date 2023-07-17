import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/todos_model.dart';
import '../../services/todos_services.dart';
part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(TodosInitial()) {
    getTodos();
  }

  List<TodosModel> todos = [];
  bool isLoading = true;

  getTodos() async {
    emit(TodosLoading());
    try {
      todos = await TodosService().getTodosData();
      isLoading = false;
      emit(TodosSuccess());
    } catch (e) {
      print(e.toString());
      emit(TodosError());
    }
  }
}
