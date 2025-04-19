import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String id;
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;
  String userId;

  Todo({
    this.id = '',
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
    required this.userId,
  });

  // Firestore'dan veri oluşturma
  factory Todo.fromFirestore(Map<String, dynamic> data, String docId) {
    return Todo(
      id: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      userId: data['userId'] ?? '',
    );
  }

  // Firestore'a gönderilecek veri
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
    };
  }

  // Güncellenmiş kopya oluşturur
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    String? userId,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }
}
