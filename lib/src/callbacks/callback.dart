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
    bot.onCallbackQuery(_callback);
  }
}

abstract class CallbackWithData<T> extends Callback<T> {
  T parser(String data);

  @override
  Future<void> callback(Context ctx, CallbackQuery query) async {}
  Future<void> callbackData(Context ctx, T data, CallbackQuery query);

  @override
  bool isValid(CallbackQuery query) {
    return query.data != null && isValidData(query.data!);
  }

  bool isValidData(String data);

  @override
  Future<void> _callbackQuery(Context ctx, CallbackQuery query) async {
    super._callbackQuery(ctx, query);
    if (query.data == null){
      print("Warning! CallbackWithData wait data, but is not exist!");
    }else{
      final parsedData = parser(query.data!);
      callbackData(ctx, parsedData, query);
    }
  }
}