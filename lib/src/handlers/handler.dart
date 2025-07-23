import 'dart:async';
import 'package:televerse/televerse.dart';
import 'package:televerse_plus/src/bot/bot.dart';

abstract class Handler {
  FutureOr<void> handle(Context ctx);

  void register(BotPlus bot);

  FutureOr<void> Function(Context ctx) get _handler => handle;
}

abstract class FilteringHandler extends Handler {
  bool filter(Context ctx);

  bool Function(Context ctx) get _filter => filter;

  @override
  void register(BotPlus bot) {
    bot.bot.filter(_filter, _handler);
  }
}

abstract class CommandHandler extends Handler {
  abstract final String command;

  @override
  void register(BotPlus bot) {
    bot.bot.command(command, _handler);
  }
}