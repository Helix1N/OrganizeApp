import 'package:flutter/material.dart';

class TaskTypeCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final int countTasks;
  final String title;
  final double height = 90;
  const TaskTypeCard(
      {super.key,
      required this.color,
      required this.icon,
      required this.countTasks,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: color.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: color),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "$countTasks Tasks",
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
      ),
    );
  }
}
