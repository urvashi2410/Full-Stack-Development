import 'package:flutter/material.dart';
import 'package:frontend/Models/todo.dart';
import 'package:frontend/todo_container.dart';
import 'package:pie_chart/pie_chart.dart';
import 'Constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int complete = 0;
  List<Todo> myTodos = [];
  bool isLoading = true;
  void fetchData() async {
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
        if (todo['isDone']) {
          complete += 1;
        }
        myTodos.add(t);
      });
      print(myTodos.length);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error is $e');
    }
  }

  void delete_todo(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse(api + "/" + id));
      fetchData();
      setState(() {
        
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF001133),
        appBar: customAppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              PieChart(
                dataMap: {
                  'Complete': complete.toDouble(),
                  'Incomplete': (myTodos.length - complete).toDouble()
                },
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      children: myTodos.map((e) {
                        return TodoContainer(
                          onPress: () => delete_todo(e.id.toString()),
                            title: e.title,
                            desc: e.desc,
                            isDone: e.isDone,
                            id: e.id);
                      }).toList(),
                    )
            ],
          ),
        ));
  }
}
