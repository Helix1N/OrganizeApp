import 'package:flutter/material.dart';
import 'package:organiza_app/custom_widgets/task_type_card.dart';
import 'package:organiza_app/custom_widgets/task_card.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndexNavbar = 0;

  List<Widget> listTaskCard = [
    TaskCard(
      title: "Varrer Sala",
      subtitle: "15 Horas",
      countTasks: 0,
    ),
    TaskCard(
      title: "Lavar Louça",
      subtitle: "13 Horas",
      countTasks: 0,
    ),
    TaskCard(
      title: "Comer Salada",
      subtitle: "18 Horas",
      countTasks: 0,
    ),
    TaskCard(
      title: "Lavar Louça",
      subtitle: "19 Horas",
      countTasks: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Call your function to prepare the list
    listTaskCard = addSizedBoxToList(listTaskCard, 10.0, 0.0);
  }

  List<Widget> addSizedBoxToList(
      List<Widget> list, double height, double width) {
    List<Widget> newList = [];

    for (var widget in list) {
      newList.add(widget);
      newList.add(SizedBox(
        width: width,
        height: height,
      ));
    }

    return newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titleHome(),
        actions: [_actionsHome()],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: ListView(padding: EdgeInsets.only(left: 20, right: 20), children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              taskTypeCards(),
              SizedBox(
                height: 40,
              ),
              Text(
                "Recent Tasks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: listTaskCard,
              )
            ],
          ),
        ),
      ]),
    );
  }

  Column taskTypeCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 20),
              child: TaskTypeCard(
                icon: Icons.refresh,
                title: "On going",
                height: 90,
                width: 0,
                color: Colors.blue,
                countTasks: 0,
              ),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 20),
                child: TaskTypeCard(
                  icon: Icons.av_timer,
                  title: "In Process",
                  height: 90,
                  width: 0,
                  color: Colors.orange,
                  countTasks: 0,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: TaskTypeCard(
                  icon: Icons.checklist,
                  title: "Completed",
                  height: 90,
                  width: 0,
                  color: Colors.green,
                  countTasks: 0,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: TaskTypeCard(
                  icon: Icons.error_outline,
                  title: "Canceled",
                  height: 90,
                  width: 0,
                  color: Colors.red,
                  countTasks: 0,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Container _titleHome() {
    return Container(
        child: Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
      child: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(right: 240.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black)),
                child: Center(child: Text("Foto")),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi, ${widget.username}",
                      style: TextStyle(fontSize: 22),
                    ),
                    Text(
                      "Your daily adventure starts here!",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Padding _actionsHome() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Container(
        child: Text("Actions"),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.checklist,
            size: 30,
          ),
          label: 'Check',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add,
            size: 30,
          ),
          label: 'add',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 30,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndexNavbar,
      selectedItemColor: Colors.blue.withOpacity(0.7),
      onTap: (int index) {
        setState(() {
          _selectedIndexNavbar = index;
        });
      },
    );
  }
}
