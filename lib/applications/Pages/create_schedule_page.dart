import 'package:flutter/material.dart';
import 'package:gymapp/applications/Models/day_schedule.dart';
// ignore: library_prefixes
import '../Utils/compile_day_schedule.dart';
import '../Utils/drawer.dart' as Drawer;

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key});

  @override
  State<CreateSchedule> createState() => _MyCreateSchedule();
}

class _MyCreateSchedule extends State<CreateSchedule> {
  //Text Input :
  TextEditingController nomeScheda = TextEditingController();
  TextEditingController numeroGiorni = TextEditingController();
  List<DaySchedule> giorniScheda = [];

  //Principal Widget :
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer.NavigationDrawer(),
      appBar: AppBar(
        title: const Text('Add Schedule'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 16.0,
            ),
            textWelcome(),
            const SizedBox(
              height: 8,
            ),
            textNome(),
            const SizedBox(
              height: 10.0,
            ),
            inputNome(),
            const SizedBox(
              height: 10.0,
            ),
            textNumeroGiorni(),
            const SizedBox(
              height: 10.0,
            ),
            inputNumeroGiorni(),
            const SizedBox(
              height: 20.0,
            ),
            buttonCompileSchedule(),
          ],
        ),
      ),
    );
  }

  //Other Widget :
  Widget textWelcome() => const Text(
        'Crea la tua scheda di allenamento',
        style: TextStyle(
          fontSize: 21,
        ),
      );

  Widget textNome() => const Text(
        'Nome Scheda',
        style: TextStyle(fontSize: 16.0),
      );

  Widget inputNome() => TextFormField(
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            filled: true,
            hintText: 'Nome della Scheda',
            labelText: 'Nome *'),
        controller: nomeScheda,
      );

  Widget textNumeroGiorni() => const Text(
        'Numero giorni di allenamento',
        style: TextStyle(fontSize: 16.0),
      );

  Widget inputNumeroGiorni() => TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.orange),
            ),
            filled: true,
            hintText: 'Numero Allenamenti',
            labelText: 'Numero *'),
        controller: numeroGiorni,
      );

  Widget buttonCompileSchedule() => ElevatedButton(
      onPressed: () => _showCompileForm(context),
      child: const Text('Compila Scheda'));

  //Methods for this Page :
  void _showCompileForm(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: CompileDaySchedule(_addFirstDataExpense),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  void _addFirstDataExpense(DaySchedule daySchedule) {
    setState(() {
      giorniScheda.add(daySchedule);
    });
  }
}
