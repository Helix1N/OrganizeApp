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
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(width: 2, color: Colors.black)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.subtitle,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(Icons.check_circle),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("${widget.countTasks} Tasks")
                  ],
                )
              ],
            ),
          ),
          const Text(
            "Foto",
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}
