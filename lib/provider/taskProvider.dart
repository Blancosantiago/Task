import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'TareasM.dart';

class TareasList with ChangeNotifier {
  final String authToken;
  final String usrid;
  List<TaskMode> _items = [];

  TareasList(this.authToken, List list, this.usrid);

  List<TaskMode> get items {
    return [..._items];
  }

  Future<void> fetchtasks() async {
    final url =
        'https://us-central1-santiago-test-c6a4c.cloudfunctions.net/api/v1/collections/tasks';
    Map<String, String> map = {
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: map);
      final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;

      if (extractedData == null) {
        return;
      }
      final List<TaskMode> listtask = [];
      List<dynamic> respdata = json.decode(response.body)["data"];

      for (var i = 0; i < respdata.length; i++) {
        TaskMode taskmodes = TaskMode();
        LinkedHashMap dataMap = respdata.elementAt(i);
        dataMap.forEach((key, value) {
          if (key == "uid") {
            taskmodes.id = value;
          } else {
            taskmodes.descripcion = value["descripcion"];
            taskmodes.titulo = value["titulo"];
            taskmodes.hora = DateTime.parse(value["hora"]);
            taskmodes.terminado = value["terminado"];
            taskmodes.horaFinal = value["horaFinal"] == "null"
                ? null
                : DateTime.parse(value["horaFinal"]);
          }
        });
        listtask.add(taskmodes);
      }

      _items = listtask;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateTask(String id, TaskMode tarea) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    _items[prodIndex] = tarea;
    notifyListeners();
    if (prodIndex >= 0) {
      final url =
          "https://us-central1-santiago-test-c6a4c.cloudfunctions.net/api/v1/collections/tasks/$id";
      Map<String, String> map = {
        "Authorization": "Bearer $authToken",
        "Content-Type": "application/json"
      };

      var response = await http.post((Uri.parse(url)),
          headers: map,
          body: json.encode({
            "titulo": tarea.titulo,
            "descripcion": tarea.descripcion,
            "hora": tarea.hora.toIso8601String(),
            "horaFinal": tarea.horaFinal.toIso8601String(),
            "terminado": tarea.terminado,
          }));
      _items[prodIndex] = tarea;

      notifyListeners();
      print(response.statusCode.toString());
    } else {
      print('...');
    }
  }

  Future<void> addTasks(TaskMode tarea) async {
    final url =
        "https://us-central1-santiago-test-c6a4c.cloudfunctions.net/api/v1/collections/tasks";

    Map<String, String> map = {
      "Authorization": "Bearer $authToken",
      "Content-Type": "application/json"
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: map,
        body: json.encode({
          "titulo": tarea.titulo,
          "descripcion": tarea.descripcion,
          "hora": tarea.hora.toIso8601String(),
          "horaFinal": "null",
          "terminado": tarea.terminado,
        }),
      );
      final newProduct = TaskMode(
        id: json.decode(response.body)['uid'],
        titulo: tarea.titulo,
        descripcion: tarea.descripcion,
        hora: tarea.hora,
        horaFinal: null,
        terminado: tarea.terminado,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
