import 'package:gymapp/applications/Models/account.dart';
import 'package:hive/hive.dart';

class BoxesAccount {
  static Box<Account> getDataExpenses() => Hive.box<Account>('getAccount');
}
