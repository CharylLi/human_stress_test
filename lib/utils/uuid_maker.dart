import 'package:uuid/uuid.dart';

//a specific type of string for naming purposes
typedef UUIDString = String;

//a class to make uuid using flutter object
class UUIDMaker {
  //generating a uuid class
  static const uuid = Uuid();

  //randomly generating the actual uuid using the
  //built-in function .v4()
  static UUIDString generateUUID() {
    return uuid.v4();
  }
}
