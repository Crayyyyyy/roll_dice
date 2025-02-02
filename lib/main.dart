import 'package:flutter/material.dart';
import 'package:roll_dice/pages/pageRNG/pageRNG.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: PageRNG(),
    ),
  );
}

// PALLETE:
// Black:     #2b2d42
// Gray:      #8d99ae
// White:     #edf2f4
// LightRed:  #ef233c
// DarkRed:   #d90429
