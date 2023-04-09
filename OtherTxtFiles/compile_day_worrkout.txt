import 'package:flutter/material.dart';
import 'package:gymapp/applications/Models/exercise.dart';

import '../../Utils/print_message.dart';

/// Class that creates a particular Widget,
/// which is used to fill in the first object
/// of an Expense. It is invoked by pressing
/// a button in the specific part of the program
/// for creating an expense.
class CompileExercise extends StatefulWidget {
  final Function(Exercise) addExercise;

  const CompileExercise(this.addExercise, {super.key});

  @override
  State<CompileExercise> createState() => _MyCompileExercise();
}

class _MyCompileExercise extends State<CompileExercise> {
  //Controller Attributes for Name (DataExpense) and Price (DataExpense):
  TextEditingController muscoliAllenati = TextEditingController();
  List<Exercise> esercizi = [];

  TextEditingController nomeEsercizio = TextEditingController();
  TextEditingController ripetizioni = TextEditingController();
  TextEditingController peso = TextEditingController();

  //Object type  PrintStatus:
  PrintStatus statusMessage = PrintStatus();

  //Build the effective Class Widget (Compile first element for TotalExpense).
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 350,
      width: 400,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            _formWidgetText(
                'Name Exercise', 'Name', 'Enter valid name', nomeEsercizio),
            const SizedBox(height: 15),
            _formWidgetText(
                'Enter number Rep', 'Rep', 'Enter a valid rep', ripetizioni),
            const SizedBox(height: 10),
            _formWidgetNumber('Enter start weight', 'Weight', peso),
            const SizedBox(
              height: 16,
            ),
            _lastRowButtons(nomeEsercizio, ripetizioni, peso, context)
          ],
        ),
      ),
    );
  }

  /// For simplicity, without having
  /// to instantiate and create objects
  /// directly within the build method,
  /// they are created out separately for a simpler
  /// code structure and modular.

  Widget _formWidgetText(
          hintText, labelText, errorText, TextEditingController controller) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            )),
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          int days = int.tryParse(value) ?? 0;
          if (days <= 0) {
            return errorText;
          }
          return null;
        },
      );

  Widget _formWidgetNumber(
          hintText, labelText, TextEditingController controller) =>
      TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            )),
      );

  Widget _lastRowButtons(
          TextEditingController controller1,
          TextEditingController controller2,
          TextEditingController controller3,
          BuildContext context) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            onPressed: () => _clearInput(controller1, controller2, controller3),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Clear'),
          ),
          ElevatedButton(
              onPressed: () => _addDayExercises(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text('Save exercise')),
        ],
      );

  //Internal Methods: (Button _clearInput and Button _addExpense):
  //Button _clearInput.
  void _clearInput(TextEditingController controller1,
      TextEditingController controller2, TextEditingController controller3) {
    controller1.clear();
    controller2.clear();
    controller3.clear();
  }

  //Button _saveDataExpense
  void _addDayExercises(BuildContext context) {
    String nome = nomeEsercizio.value.text;
    String rip = ripetizioni.value.text;
    double weight = (double.parse(peso.text));
    if (nome.isEmpty || rip.isEmpty) {
      statusMessage.printError(context, 'Invalid Name or Rep');
    } else {
      Exercise newExercise = Exercise(nome, rip, weight);
      widget.addExercise(newExercise);
      statusMessage.printCorrect(context, 'Exercise add correctly');
      _clearInput(nomeEsercizio, ripetizioni, peso);
      Navigator.pop(context);
    }
  }
}
