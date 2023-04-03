import 'package:gymapp/applications/Models/account.dart';
import 'package:hive/hive.dart';

class BoxesAccount {
  static Box<Account> getAccount() => Hive.box<Account>('getAccount');
}
