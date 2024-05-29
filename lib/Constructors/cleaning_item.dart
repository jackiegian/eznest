import 'package:uuid/uuid.dart';

class CleaningItem {
  final String id;
  String title;
  DateTime expiration;
  String room;
  bool isDone;
  DateTime creationDate;
  DateTime completeDate;

  CleaningItem({
    required this.title,
    DateTime? expiration,
    required this.room,
    this.isDone = false,
    DateTime? creationDate,
    DateTime? completeDate
  })  : expiration = expiration ?? DateTime.now(),
        creationDate = creationDate ?? DateTime.now(),
        completeDate = completeDate ?? DateTime.now(),
        id = Uuid().v4();
}
