import 'package:hive/hive.dart';

class ToDoDataBase{
  List toDoList= [];
   // reference of the box in hompage and main
  final _myBox = Hive.box('mybox');

   //first time an open akunnen ith run cheyyanam
  void createInitialData(){
    toDoList = [
      ["Hello" , false ],
      [" Sanal" , false],
    ];
  }
  //load the data from database
void loadData() {
    toDoList = _myBox.get("TODOLIST");
}
//update database
void updateDataBase() {
    _myBox.put("TODOLIST" , toDoList);
}
}