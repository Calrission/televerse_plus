import 'package:televerse/televerse.dart';
import 'package:televerse_plus/src/bot/bot.dart';

extension BotToBotPlusExtension on Bot {
  BotPlus plus() => BotPlus(this);
}