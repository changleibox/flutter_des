import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class FlutterDes {
  static const MethodChannel _channel = const MethodChannel('flutter_des');
  static final List<int> _iv = utf8.encode('01234567');

  static Future<Uint8List> encrypt(String string, String key, {List<int> iv}) async {
    if (string.isEmpty) {
      return null;
    }
    final Uint8List crypt = await _channel.invokeMethod('encrypt', [string, key, iv ?? _iv]);
    return crypt;
  }

  static Future<String> encryptToHex(String string, String key, {List<int> iv}) async {
    if (string.isEmpty) {
      return '';
    }
    final String crypt = await _channel.invokeMethod('encryptToHex', [string, key, iv ?? _iv]);
    return crypt;
  }

  static Future<String> encryptToBase64(String string, String key, {List<int> iv}) async {
    if (string.isEmpty) {
      return '';
    }
    final String crypt = base64Encode(await encrypt(string, key, iv: iv ?? _iv));
    return crypt;
  }

  static Future<String> decrypt(Uint8List data, String key, {List<int> iv}) async {
    final String crypt = await _channel.invokeMethod('decrypt', [data, key, iv ?? _iv]);
    return crypt;
  }

  static Future<String> decryptFromHex(String hex, String key, {List<int> iv}) async {
    final String crypt = await _channel.invokeMethod('decryptFromHex', [hex, key, iv ?? _iv]);
    return crypt;
  }

  static Future<String> decryptFromBase64(String base64, String key, {List<int> iv}) async {
    final String crypt = await decrypt(base64Decode(base64), key, iv: iv ?? _iv);
    return crypt;
  }
}
