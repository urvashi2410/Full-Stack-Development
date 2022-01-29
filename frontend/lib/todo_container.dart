import 'package:flutter/material.dart';
import 'Constants/colors.dart';

class TodoContainer extends StatelessWidget {
  final int id;
  final String title;
  final String desc;
  final bool isDone;
  final Function onPress;
  const TodoContainer({
    Key? key,
    required this.title,
    required this.desc,
    required this.isDone,
    required this.id,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              children: [
                Text(
                  "Update Todo",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: title,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: desc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  
                ),
                ElevatedButton(
                    onPressed: null,
                    child: Text('Add'))
              ],
            ),
            color: Colors.white,
          );
        });
        },
        child: Container(
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
              color: isDone == true ? green : red,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () => onPress(),
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 32,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    desc,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
