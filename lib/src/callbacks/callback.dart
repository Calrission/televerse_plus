import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';
import 'package:televerse_plus/src/bot/bot.dart';

abstract class Callback<T>{
  bool isValid(CallbackQuery query);

  Future<void> call(Context ctx, CallbackQuery query);

  void onRegister(BotPlus bot){}
}

abstract class CallbackWithData<T> extends Callback<T> {
  late T data;

  (T?, bool) parser(String data);

  @override
  bool isValid(CallbackQuery query) {
    if (query.data == null){
      return false;
    }
    final result = parser(query.data!);
    if (result.$2){
      data = result.$1 as T;
    }
    return query.data != null && result.$2;
  }
}