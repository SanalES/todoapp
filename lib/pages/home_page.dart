import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 //hive boxinte reference
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

 @override
 void initState() {
   //if this opening first time ,to create default data
   if(_myBox.get("TODOLIST")==null){
     db.createInitialData();
   }else{
     //already data avde kanum
     db.loadData();
   }
   super.initState();
 }
  //text
  final _controller =TextEditingController();

//checkbox was tapped
  void checkBoxChanged(bool? value , int index) {
    setState(() {
      db.toDoList[index][1]=!db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

//delete task
   void deleteTask(int index ) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
   }

//create new task ..b
  void createNewTask(){
    showDialog(context: context,
        builder:(context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: ()=> Navigator.of(context).pop(),
      );
        },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text('To Do'),
          elevation: 0,
        ),
        floatingActionButton:FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged ( value , index),
              deleteFunction :(context) =>deleteTask(index),
            );
          },
        ));
  }
}
