import 'package:flutter/material.dart';
import 'package:frontend/Constants/colors.dart';

AppBar customAppBar() {
  return AppBar(
    title: const Text('Django TODOs'),
    backgroundColor: darkBlue,
    elevation: 0,
    centerTitle: true,
  );
}
