import 'dart:async';
import 'package:televerse/televerse.dart' hide Handler;
import 'package:televerse_plus/src/callbacks/callback.dart';
import 'package:televerse_plus/src/handlers/handler.dart';

class BotPlus {
  final Bot bot;
  final List<Callback> _callbacks = [];

  BotPlus(this.bot){
    bot.onCallbackQuery(_globalCallback);
  }

  FutureOr<void> _globalCallback(Context ctx) async {
    final query = ctx.callbackQuery;
    if (query == null){
      return;
    }
    for (final callback in _callbacks) {
      if (callback.isValid(query)){
        callback.call(ctx, query);
      }
    }
  }

  void registerCallback(Callback callback){
    _callbacks.add(callback);
    callback.onRegister(this);
  }

  void registerHandler(Handler handler){
    handler.register(this);
  }
}