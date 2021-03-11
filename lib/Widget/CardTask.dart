import 'package:autontificatio/provider/TareasM.dart';
import 'package:autontificatio/provider/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:autontificatio/Utils/reponsive.dart';
import 'package:provider/provider.dart';

class CardTasks extends StatelessWidget {
  final title;
  final DateTime hora;
  final bool finish;
  final descripcion;
  final id;
  final DateTime horaFinal;

  const CardTasks(
      {Key key,
      this.title,
      this.hora,
      this.finish,
      this.descripcion,
      this.id,
      this.horaFinal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final task1 = Provider.of<TaskMode>(context, listen: false);
    final task1 = Provider.of<TareasList>(context, listen: false);

    return Card(
      color: finish ? Colors.green.shade600 : Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 80 / 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 60 / 100,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                            textScaleFactor:
                                (ResponsiveWidget.isSmallScreen(context))
                                    ? 0.90
                                    : 1.20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              descripcion,
                              style: TextStyle(color: Colors.white),
                              textScaleFactor:
                                  (ResponsiveWidget.isSmallScreen(context))
                                      ? 0.90
                                      : 1.20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: const Icon(
                          Icons.access_time,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      (horaFinal != null)
                          ? Padding(
                              padding: const EdgeInsets.all(5),
                              child: horaFinal.difference(hora).inHours >= 24
                                  ? Text(
                                      "Days: ${horaFinal.difference(hora).inDays}",
                                      style: TextStyle(color: Colors.white),
                                      textScaleFactor:
                                          (ResponsiveWidget.isSmallScreen(
                                                  context))
                                              ? 0.90
                                              : 1.20,
                                    )
                                  : Text(
                                      "Hours:${(horaFinal.difference(hora)).inHours} or Minutes:${horaFinal.difference(hora).inMinutes}",
                                      style: TextStyle(color: Colors.white),
                                      textScaleFactor:
                                          (ResponsiveWidget.isSmallScreen(
                                                  context))
                                              ? 0.90
                                              : 1.20,
                                    ),
                            )
                          : Container(
                              child: null,
                            )
                    ],
                  )
                ],
              ),
              Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: Icon(finish ? Icons.fact_check_outlined : Icons.check),
                  color: finish
                      ? Colors.green.shade600
                      : Theme.of(context).primaryColor,
                  onPressed: () {
                    if (finish == false) {
                      task1.updateTask(
                          id.toString(),
                          TaskMode(
                              descripcion: descripcion,
                              hora: hora,
                              id: id.toString(),
                              titulo: title,
                              horaFinal: DateTime.now(),
                              terminado: true));
                    } else {}
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
