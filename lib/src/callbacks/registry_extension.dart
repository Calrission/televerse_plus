import 'package:televerse/televerse.dart';

import 'callback.dart';

extension CallbackRegister on Bot {
  void registerCallback(Callback callback) {
    callback.register(this);
  }
}