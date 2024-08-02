import 'dart:convert';

import 'package:first_station/draw/Line.dart';
import 'package:shared_preferences/shared_preferences.dart';

String kGuessSpKey = 'guess_config';
String kMuyuSpKey = 'muyu_config';
String kPaperSpKey = 'paper_config';

class SpStorage {
  SpStorage._(); //私有化构造
  static SpStorage? _storage;

  //提供实例对象的访问途径
  static SpStorage get instance {
    _storage = _storage ?? SpStorage._();
    return _storage!;
  }

  SharedPreferences? _sp;

  Future<void> initSpWhennull() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
  }

  //配置信息读取
  Future<Map<String, dynamic>> readGuessConfig() async {
    await initSpWhennull();
    String content = _sp!.getString(kGuessSpKey) ?? "{}";
    return json.decode(content);
  }

  Future<Map<String, dynamic>> readMuyuConfig() async {
    await initSpWhennull();
    String content = _sp!.getString(kGuessSpKey) ?? "{}";
    return json.decode(content);
  }

  Future<Map<String, dynamic>> readPaperConfig() async {
    await initSpWhennull();
    String content = _sp!.getString(kGuessSpKey) ?? "{}";
    return json.decode(content);
  }

//saveGuessConfig方法用于保存猜数字的配置信息
  Future<void> saveGuess({required bool guessing, required int value}) async {
    await initSpWhennull();
    String content = json.encode({'guessing': guessing, 'value': value});
    _sp!.setString(kGuessSpKey, content);
  }

  //saveMuyuConfig方法保存木鱼配置信息
  Future<bool> saveMuyuConfig(
      {required int counter,
      required int activeImageIndex,
      required int activeAudioIndex}) async {
    await initSpWhennull();
    String content = json.encode({
      'counter': counter,
      'activeImageIndex': activeImageIndex,
      'activeAudioIndex': activeAudioIndex
    });
    return _sp!.setString(kMuyuSpKey, content);
  }

//savePaperConfig方法保存绘制配置信息
  Future<bool> savePaperConfig({
    required List<Line> list,
    required int activeColorIndex,
    required int activeStorkIndex,
  }) async {
    await initSpWhennull();
    String content = json.encode({
      'list': list,
      'activeColorIndex': activeColorIndex,
      'activeStorkIndex': activeStorkIndex
    });
    return _sp!.setString(kPaperSpKey, content);
  }
}
