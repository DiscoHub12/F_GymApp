import 'package:flutter/material.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
import 'package:gymapp/applications/Utils/print_message.dart';

/// Class that creates a particular Widget,
/// which is used to fill in the first object
/// of an Expense. It is invoked by pressing
/// a button in the specific part of the program
/// for creating an expense.
class CompileDaySchedule extends StatefulWidget {
  final Function(DaySchedule) addDaySchedule;

  const CompileDaySchedule(this.addDaySchedule, {super.key});

  @override
  State<CompileDaySchedule> createState() => _MyCompileDaySchedule();
}

class _MyCompileDaySchedule extends State<CompileDaySchedule> {
  //Controller Attributes for Name (DataExpense) and Price (DataExpense):
  TextEditingController nomeMuscolo = TextEditingController();
  TextEditingController nomeEsercizio = TextEditingController();
  TextEditingController serie = TextEditingController();
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
            _firstTextName(),
            const SizedBox(height: 10),
            _firstInputField('Muscolo', nomeMuscolo),
            const SizedBox(height: 15), 
            const SizedBox(height: 10),
            _lastRowButtons(
                nomeMuscolo, nomeEsercizio, context),
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
  Widget _firstTextName() => const Text(
        'Muscolo da allenare : ',
        style: TextStyle(fontSize: 17),
      );

  Widget _firstInputField(String hint, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: TextField(
        decoration: InputDecoration(
            labelText: hint,
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black38,
            ))),
        controller: controller,
      ),
    );
  }

  Widget _buildPriceField(String hint, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            labelText: 'Enter a value',
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.black38,
            ))),
        controller: controller,
      ),
    );
  }

  Widget _lastRowButtons(TextEditingController controller1,
          TextEditingController controller2, BuildContext context) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
              onPressed: () => _clearInput(controller1, controller2),
              child: const Text('Clear')),
          ElevatedButton(
              onPressed: () => _addExpense(context),
              child: const Text('Add Element')),
        ],
      );

  //Internal Methods: (Button _clearInput and Button _addExpense):
  //Button _clearInput.
  void _clearInput(
      TextEditingController controller1, TextEditingController controller2) {
    controller1.clear();
    controller2.clear();
  }

  //Button _saveDataExpense
  void _addExpense(BuildContext context) {
    /**
     String nameTmp = nameDataExpenseController.text;
    double priceTmp = (double.parse(priceDataExpenseController.text));
    if (nameTmp == "" || priceTmp == 0) {
      statusMessage.printError(context, 'Invalid Name or Pice.');
    } else {
      DataExpense dataExpenseTmp = DataExpense(nameTmp, priceTmp);
      widget.addDataExpense(dataExpenseTmp);
      statusMessage.printCorrect(context, 'Expense element added.');
      _clearInput(nameDataExpenseController, priceDataExpenseController);
      Navigator.pop(context);
    }
     */
  }

  /**
  class CompileSchedule extends StatefulWidget {
  const CompileSchedule({super.key});

  @override
  State<StatefulWidget> createState() => _MyCompileSchedule();
}

class _MyCompileSchedule extends State<CompileSchedule> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compila il form'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Inserisci il tuo nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  firstName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Cognome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Inserisci il tuo cognome';
                  }
                  return null;
                },
                onSaved: (value) {
                  lastName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Inserisci la tua email';
                  } else if (!value.contains('@')) {
                    return 'Inserisci un\'email valida';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    // Fai qualcosa con i dati inseriti dall'utente
                  }
                },
                child: Text('Invia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

   */
}
