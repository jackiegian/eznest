import 'package:exam/Constructors/account.dart';
import 'package:uuid/uuid.dart';

class ShoppingItem {
  final String id;
  final String title;
  late Account buyer;
  final int quantity;
  bool isComplete;

  ShoppingItem({
    required this.title,
    required this.quantity,
    required this.buyer,
    this.isComplete = false,
  }) : id = Uuid().v4(); // Genera un ID univoco al momento della creazione
}