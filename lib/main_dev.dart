import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/bootstrap/bootstrap.dart';
import 'package:flutter_enterprise_boilerplate/core/utils/functions/debuggable.dart';

Future<void> main() async {
  Debuggable.debugEnabled = true;
  
  await Bootstrap.initialize(
    flavor: Flavor.dev,
    envPath: '.env.dev',
  );
}
