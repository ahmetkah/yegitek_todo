import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'FIREBASE_API_KEY')
  static const String apiKey = _Env.apiKey;

  @EnviedField(varName: 'FIREBASE_APP_ID')
  static const String appId = _Env.appId;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID')
  static const String messagingSenderId = _Env.messagingSenderId;

  @EnviedField(varName: 'FIREBASE_PROJECT_ID')
  static const String projectId = _Env.projectId;

  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET')
  static const String storageBucket = _Env.storageBucket;
}
