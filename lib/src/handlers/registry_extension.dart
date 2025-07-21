import 'package:televerse/televerse.dart' hide Handler;
import 'handler.dart';

extension HandlerRegister on Bot {
  void registerHandler(Handler handler){
    handler.register(this);
  }
}