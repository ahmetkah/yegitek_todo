import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/todo.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Koleksiyon referansı
  CollectionReference get _todosCollection => _firestore.collection('todos');

  // Kullanıcının tüm todoları
  Stream<List<Todo>> getTodos() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _todosCollection.where('userId', isEqualTo: userId).snapshots().map((
      snapshot,
    ) {
      final todos =
          snapshot.docs
              .map(
                (doc) => Todo.fromFirestore(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList();

      // Sıralamayı kod tarafında yapalım
      todos.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return todos;
    });
  }

  // Yeni todo ekle
  Future<void> addTodo(String title, String description) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _todosCollection.add(
      Todo(
        title: title,
        description: description,
        createdAt: DateTime.now(),
        userId: userId,
      ).toFirestore(),
    );
  }

  // Todo güncelle
  Future<void> updateTodo(Todo todo) async {
    await _todosCollection.doc(todo.id).update(todo.toFirestore());
  }

  // Todo sil
  Future<void> deleteTodo(String todoId) async {
    await _todosCollection.doc(todoId).delete();
  }

  // Tamamlandı durumunu değiştir
  Future<void> toggleTodoStatus(Todo todo) async {
    await _todosCollection.doc(todo.id).update({
      'isCompleted': !todo.isCompleted,
    });
  }
}
