import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:organiza_app/custom_widgets/bottom_nav.dart';
import 'package:organiza_app/custom_widgets/category_button.dart';
import 'package:organiza_app/custom_widgets/standard_text_field.dart';
import '../data/data_user.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TextEditingController _taskAssigneeController = TextEditingController();
  final TextEditingController _taskSubtitleController = TextEditingController();
  bool _getAlertTask = true;

  void _createTask() async {
    if (_taskTitleController.text == "" ||
        _taskDescriptionController.text == "" ||
        _taskAssigneeController.text == "" ||
        _taskSubtitleController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are not set')),
      );
    } else {
      var url = Uri.parse('http://10.0.2.2:8080/task');
      var client = HttpClient();

      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      try {
        var request = await client.postUrl(url);
        request.headers.set('content-type', 'application/json');

        var payload = json.encode({
          "userId": UserData().id,
          "title": _taskTitleController.text,
          "description": _taskDescriptionController.text,
          "subtitle": _taskSubtitleController.text,
          "status": 1
        });
        request.write(payload);

        var response = await request.close();

        if (response.statusCode == 200) {
          var responseBody = await response.transform(utf8.decoder).join();
          var jsonResponse = json.decode(responseBody);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Request failed with status ${response.statusCode}')),
          );
        }
      } catch (e) {
        print('Error during HTTP request: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during HTTP request: $e')),
        );
      } finally {
        client.close();
      }
    }
  }

  String? _selectedAssignee;
  String? _selectedGroup;
  List<String> _spinnerItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  @override
  void dispose() {
    _taskTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNav(selectedIndexNavbar: 2, context: context),
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.tab)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.mark_chat_read))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Tasks",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      StandardTextField(
                        hintText: "| Task Title",
                        textEditingController: _taskTitleController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      StandardTextField(
                        hintText: "| Subtitle",
                        textEditingController: _taskSubtitleController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButton<String>(
                        value: _selectedGroup,
                        hint: Text('Select a group'),
                        items: _spinnerItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedGroup = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButton<String>(
                        value: _selectedAssignee,
                        hint: Text('Select an assignee'),
                        items: _spinnerItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedAssignee = newValue;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      StandardTextField(
                        hintText: "| Task Description",
                        textEditingController: _taskTitleController,
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.hd)),
                          IconButton(onPressed: () {}, icon: Icon(Icons.flag)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.join_inner)),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CategoryButton(category: "Semanal"),
                          SizedBox(
                            width: 20,
                          ),
                          CategoryButton(category: "Diária")
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Get alert for this task",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w800),
                          ),
                          Switch(
                              value: _getAlertTask,
                              onChanged: (value) {
                                setState(() {
                                  _getAlertTask = value;
                                });
                              })
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20, bottom: 20, top: 20),
                  child: Center(
                    child: GestureDetector(
                      onTap: _createTask,
                      child: Container(
                        alignment: Alignment.center,
                        height: screenSize.height * 0.075,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.8),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        child: Text(
                          "Create Task",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
