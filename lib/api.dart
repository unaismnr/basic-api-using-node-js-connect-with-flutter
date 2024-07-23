import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:node_crud/model.dart';

class Api {
  static Future<List<Model>> getData() async {
    try {
      final res = await http.get(
        Uri.parse('http://localhost:5000/todos'),
      );
      if (res.statusCode == 200) {
        final List<dynamic> parsed = jsonDecode(res.body);
        return parsed.map((e) => Model.fromJson(e)).toList();
      } else {
        throw Exception('Failed to Load');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Model>> postData(Model data) async {
    try {
      final res = await http.post(
        Uri.parse('http://localhost:5000/todos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': data.title,
          'completed': data.completed,
        }),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
      } else {
        throw Exception('Failed to Load');
      }
    } catch (e) {
      log('post api catch error: $e');
    }
    return [];
  }

  static Future<List<Model>> updateData(String id, Model data) async {
    try {
      await http.put(
          Uri.parse(
            'http://localhost:5000/todos/$id',
          ),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'title': data.title,
            'completed': data.completed,
          }));
    } catch (e) {
      rethrow;
    }
    return [];
  }

  static deleteData(String id) async {
    try {
      final res = await http.delete(
        Uri.parse(
          'http://localhost:5000/todos/$id',
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode == 200) {
        getData();
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }
}
