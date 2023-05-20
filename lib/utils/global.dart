import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import '../common/service/storage_services.dart';

class Global {
  static late StorageService storageService;
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    storageService = await StorageService().init();
  }
}
