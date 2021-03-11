import 'package:autontificatio/Widget/CardTask.dart';
import 'package:autontificatio/Widget/ShowDialogNewTask.dart';
import 'package:autontificatio/provider/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Taskpages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[600],
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddNewTask();
            },
          );
        },
      ),
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: FutureBuilder(
          future: Provider.of<TareasList>(context, listen: false).fetchtasks(),
          builder: (ctx, dataSnapshot) {
            return Container(
                width: double.infinity,
                child: Consumer<TareasList>(
                  builder: (ctx, tasks, _) => ListView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: tasks.items.length,
                    itemBuilder: (ctx, i) => CardTasks(
                      id: tasks.items[i].id,
                      horaFinal: tasks.items[i].horaFinal,
                      descripcion: tasks.items[i].descripcion,
                      finish: tasks.items[i].terminado,
                      hora: tasks.items[i].hora,
                      title: tasks.items[i].titulo,
                    ),
                  ),
                ));
          }),
    );
  }
}
