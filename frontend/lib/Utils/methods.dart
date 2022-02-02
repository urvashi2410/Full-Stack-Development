import 'package:flutter/material.dart';
import 'package:frontend/Models/todo.dart';
import 'package:frontend/todo_container.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Widgets/app_bar.dart';
import '../Constants/colors.dart';

class HelperFunction {
  Future<List<dynamic>> fetchData() async {
    List<Todo> myTodos = [];
    try {
      http.Response response = await http.get(Uri.parse(api));
      var data = json.decode(response.body);
      data.forEach((todo) {
        Todo t = Todo(
            id: todo['id'],
            title: todo['title'],
            desc: todo['desc'],
            isDone: todo['isDone'],
            date: todo['date']);
        myTodos.add(t);
      });
      print(myTodos.length);
      return myTodos;
    } catch (e) {
      print('Error is $e');
    }
    return myTodos;
  }

  Future<void> delete_todo(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + "/" + id));
      fetchData();
    } catch (e) {
      print(e);
    }
  }

  Future<void> postData({String title = "", String desc = ""}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'title': title,
          'desc': desc,
          'isDone': false,
        }),
      );

      if (response.statusCode == 201) {
        fetchData();
      } else {
        print("Something went wrong");
      }
    } catch (e) {}
  }
}
