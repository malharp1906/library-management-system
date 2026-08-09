import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api/books';

  static Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/read'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load inventory');
    }
  }

  static Future<Book> createBook(Book book) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(book.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Book.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to save book');
    }
  }

  static Future<void> deleteBook(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete book');
    }
  }
}
