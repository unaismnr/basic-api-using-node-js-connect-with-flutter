import 'package:flutter/material.dart';
import 'package:node_crud/api.dart';
import 'package:node_crud/model.dart';

class AddEdit extends StatefulWidget {
  final String? id;
  final String? title;
  final bool? complete;
  const AddEdit({
    super.key,
    this.id,
    this.title,
    this.complete,
  });

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final titleController = TextEditingController();
  int radioValue = 1;
  bool isCompleted = false;

  @override
  void initState() {
    titleController.text = widget.title ?? '';
    isCompleted = widget.complete ?? false;
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Add Title',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Value';
                  }
                  return null;
                },
              ),
              RadioMenuButton(
                value: 1,
                groupValue: radioValue,
                onChanged: (value) {
                  setState(() {
                    radioValue = 1;
                    isCompleted = !isCompleted;
                  });
                },
                child: const Text('Not Completed'),
              ),
              RadioMenuButton(
                value: 2,
                groupValue: radioValue,
                onChanged: (value) {
                  setState(() {
                    radioValue = 2;
                    isCompleted = !isCompleted;
                  });
                },
                child: const Text('Completed'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.id != null ? updateData(context) : addData(context);
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addData(BuildContext context) {
    final dataModel = Model(
      title: titleController.text.trim(),
      completed: isCompleted,
    );

    Api.postData(dataModel);
    Navigator.pop(context);
  }

  void updateData(BuildContext context) {
    final dataModel = Model(
      title: titleController.text.trim(),
      completed: isCompleted,
    );

    Api.updateData(widget.id!, dataModel);
    Navigator.pop(context);
  }
}
