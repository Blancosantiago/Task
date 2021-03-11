import 'package:autontificatio/provider/TareasM.dart';
import 'package:autontificatio/provider/taskProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewTask extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();
  var _tasks = TaskMode(
    id: null,
    titulo: '',
    descripcion: "",
    hora: DateTime.now(),
    terminado: false,
  );
  var _initValues = {
    "id": null,
    "titulo": '',
    "descripcion": "",
    "hora": DateTime.now(),
    "terminado": false,
  };
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  void dispose() {
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<TareasList>(context, listen: false).addTasks(_tasks);
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred'),
          content: Text('Something went wrong'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      children: [
        _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: 350,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _form,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Text(
                              "New task",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_titleFocusNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _tasks = TaskMode(
                              id: _tasks.id,
                              titulo: value,
                              descripcion: _tasks.descripcion,
                              hora: _tasks.hora,
                              terminado: _tasks.terminado,
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['Task description'],
                          decoration:
                              InputDecoration(labelText: 'Task description'),
                          textInputAction: TextInputAction.next,
                          focusNode: _titleFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_descriptionFocusNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a value.';
                            }
                          },
                          onSaved: (value) {
                            _tasks = TaskMode(
                              id: _tasks.id,
                              titulo: _tasks.titulo,
                              descripcion: value,
                              hora: _tasks.hora,
                              terminado: _tasks.terminado,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              "New task",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: _saveForm,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
