
import 'package:objectbox/objectbox.dart';



@Entity()
class Message {

  @Id()
  int id = 0;

  int? receiverId;

  int? senderID;

  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime? date;


}
