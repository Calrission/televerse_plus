import 'dart:async';
import 'package:televerse/televerse.dart';

abstract class Handler {
  FutureOr<void> handle(Context ctx);

  void register(Bot bot);

  FutureOr<void> Function(Context ctx) get _handler => handle;
}

abstract class FilteringHandler extends Handler {
  bool filter(Context ctx);

  bool Function(Context ctx) get _filter => filter;

  @override
  void register(Bot bot) {
    bot.filter(_filter, _handler);
  }
}

abstract class CommandHandler extends Handler {
  abstract final String command;

  @override
  void register(Bot bot) {
    bot.command(command, _handler);
  }
}