
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/model/task_model.dart';

import '../controller/tasks_controller.dart';
import '../widgets/input_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskController = TextEditingController();
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    tasks = await getAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        // elevation: 0,
        title: Text('Todo App',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
            child: Container(
              padding: EdgeInsets.all(8),
              height: 700,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: inputText(taskController)
                  ),
                const  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        )
                        ,
                          onPressed: ()async{
                            saveTasks(Task(title: taskController.text, isCompleted: false));
                            await loadTasks();
                            setState(() {

                            });
                            taskController.clear();
                          },
                          label: Icon(Icons.add,color: Colors.white,), icon: Text('Add',style: TextStyle(color: Colors.white),)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('All Tasks',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListView.builder(
                    itemCount:tasks.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index){
                          var data = tasks[index];
                          return Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      offset: Offset(0, 3)
                                  )
                                ]
                            ),
                            child: Stack(
                              children: [
                                 ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      child: Text('${index+1}'),
                                    ),
                                    title: Text(data.title.toString()),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Checkbox(value:data.isCompleted, onChanged: (val){
                                          setState(() {
                                            data.isCompleted =val!;
                                          });
                                        }),
                                        IconButton(onPressed: ()async{
                                          setState(() {
                                            tasks.removeAt(index);
                                          });
                                          deleteTask(index);
                                          await loadTasks();
                                        },
                                            icon: Icon(Icons.delete, color: Colors.red,))
                                      ],

                                    )
                                ),
                                if(data.isCompleted)
                                  Positioned(
                                    top: 10,
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                child: Baseline(baseline: 20, baselineType: TextBaseline.alphabetic, child: Divider(color: Colors.green,),)),

                              ],
                            ),
                          );
                        }
                    )
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
