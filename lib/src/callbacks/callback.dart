import 'package:televerse/telegram.dart';
import 'package:televerse/televerse.dart';

abstract class Callback<T>{
  bool isValid(CallbackQuery query);

  Future<void> callback(Context ctx, CallbackQuery query);

  Future<void> _callbackQuery(Context ctx, CallbackQuery query) async {
    await callback(ctx, query);
  }

  Future<void> _callback(Context ctx) async {
    final query = ctx.callbackQuery;
    if (query == null){
      return;
    }
    if (isValid(query)){
      _callbackQuery(ctx, query);
    }
  }

  void register(Bot bot){
    bot.callbackQuery(RegExp(''), _callback);
  }
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

  @override
  Future<void> _callbackQuery(Context ctx, CallbackQuery query) async {
    if (query.data == null){
      print("Warning! CallbackWithData wait data, but is not exist!");
    }else{
      if (isValid(query)){
        callback(ctx, query);
      }
    }
  }
}