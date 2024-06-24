import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final int countTasks;
  const TaskCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.countTasks});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 2, color: Colors.black)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.subtitle,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(Icons.check_circle),
                    SizedBox(
                      width: 5,
                    ),
                    Text("${widget.countTasks} Tasks")
                  ],
                )
              ],
            ),
          ),
          Text(
            "Foto",
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}
