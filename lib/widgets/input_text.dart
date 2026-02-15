
import 'package:flutter/material.dart';

Widget inputText(taskController){
  return TextField(
    controller: taskController,
    decoration: InputDecoration(
        hintText: 'Add Task...',
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none
        )
    ),
  );
}