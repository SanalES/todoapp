import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_button.dart';

class DialogBox extends StatelessWidget {

  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

   DialogBox({
    super.key ,
    required this.controller,
    required this.onSave,
    required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow [300],

      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            TextField(
              controller: controller ,
              decoration:
              InputDecoration(border:
              OutlineInputBorder(),
              hintText: "Add a new task" ),
            ),

            //button - save and cancel evde

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save button
                MyButton(text: "Save", onPressed:onSave),

                const SizedBox(width: 8,),
                //cancel button
                MyButton(text: "Cancel", onPressed:onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
