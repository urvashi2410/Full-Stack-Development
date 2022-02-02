import 'package:flutter/material.dart';
import 'package:frontend/Models/todo.dart';
import 'package:frontend/todo_container.dart';
import 'package:pie_chart/pie_chart.dart';
import '../Constants/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Widgets/app_bar.dart';
import '../Constants/colors.dart';
import 'package:frontend/Utils/methods.dart';

HelperFunction helperFunction = HelperFunction();

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int complete = 0;
  List<Todo> myTodos = [];
  bool isLoading = true;

  void _showModel() {
    String title = "";
    String desc = "";
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              children: [
                Text(
                  "Add your Todo",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        desc = value;
                      });
                    }),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      desc = value;
                    });
                  },
                ),
                ElevatedButton(onPressed: () {}, child: Text('Add'))
              ],
            ),
            color: Colors.white,
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: customAppBar(),
      body: FutureBuilder(
          future: helperFunction.fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget widget = Text("");
            if (snapshot.hasData) {
              widget = SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    PieChart(
                      dataMap: {
                        'Complete': complete.toDouble(),
                        'Incomplete': (myTodos.length - complete).toDouble(),
                      },
                    ),
                    Center(
                      child: Text(snapshot.data[0].title.toString()),
                    ),
                        Column(
                            children: snapshot.data.map<Widget>((e) {
                              return TodoContainer(
                                title: e.title.toString(),
                                id: e.id,
                                onPress: (){},
                                desc: e.desc.toString(),
                                isDone: e.isDone,
                              );
                            }).toList(),
                          )
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              widget = const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              widget = const Center(
                child: Text("Something went wrong"),
              );
            }
            return widget;
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showModel();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
