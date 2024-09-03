import 'package:crypto_track/src/app.dart';
import 'package:crypto_track/src/configs%20/adapter/adapter_conf.dart';
import 'package:crypto_track/src/configs%20/injector/injector_conf.dart';
import 'package:crypto_track/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    Hive.initFlutter(),
    
    getTemporaryDirectory().then((path) async {
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: path,
      );
    }),
  ]);
  configureAdapter();
  configureDependencies();
  runApp(const MyApp());
}
