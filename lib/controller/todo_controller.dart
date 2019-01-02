import '../rest.dart';

import '../model/todo.dart';

List todos = [];

class TodoController extends ResourceController {
    ManagedContext context;

    TodoController(this.context);

    @Operation.get()
    Future<Response> getAllTodos() async {
        final todoQuery = Query<Todo>(context);
        return Response.ok(await todoQuery.fetch());
    }
    @Operation.get('id')
    Future<Response> getTodo(@Bind.path('id') int id) async {
        final todoQuery = Query<Todo>(context)
            ..where((todo)=> todo.id).equalTo(id);
        final todo = await todoQuery.fetchOne();
        if (todo == null){
            return Response.notFound(body: 'Item not found.');
        } else {
            return Response.ok(todo);
        }
    }

    @Operation.post()
    Future<Response> createNewTodo(@Bind.body() Todo body) async {
        final todoQuery = Query<Todo>(context)
            ..values = body;
        final insertTodo = await todoQuery.insert();

        return Response.ok(insertTodo);
    }
    @Operation.put('id')
    Future<Response> updateTodo(@Bind.path('id') int id, @Bind.body() Todo body) async {
        final todoQuery = Query<Todo>(context)
            ..values = body
            ..where((todo)=> todo.id).equalTo(id);
        final updatedQuery = await todoQuery.updateOne();
        if (updatedQuery == null){
            return Response.notFound(body: 'Item not found.');
        } else {
            return Response.ok(updatedQuery);
        }
    }
    @Operation.delete('id')
    Future<Response> deleteTodo(@Bind.path('id') int id, @Bind.body() Todo body) async {
          final todoQuery = Query<Todo>(context)
            ..where((todo)=> todo.id).equalTo(id);
        final deletedQuery = await todoQuery.delete();
        if (deletedQuery == 0){
            return Response.notFound(body: 'Item not found.');
        } else {
            return Response.ok('$deletedQuery Items delated.');
        }
    }
}