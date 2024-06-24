import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TaskTypeCard extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final Color color;
  final IconData icon;
  final int countTasks;

  const TaskTypeCard(
      {super.key,
      required this.title,
      required this.height,
      required this.width,
      required this.color,
      required this.icon,
      required this.countTasks});

  @override
  State<TaskTypeCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskTypeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          color: widget.color.withOpacity(0.8),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: widget.color),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "${widget.countTasks} Tasks",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.6)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
