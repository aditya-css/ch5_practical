import 'package:ch5_practical/flavour_config.dart';
import 'package:ch5_practical/main_entrypoint.dart';
import 'package:ch5_practical/utilities.dart';
import 'package:flutter/material.dart';

void main() {
  FlavourConfig(
    type: Flavour.development,
    theme: ThemeData.dark(),
    shade: ThemeData.dark().colorScheme.copyWith(
          secondary: Colors.lightBlueAccent,
          background: Colors.white,
          onBackground: Colors.black,
        ),
    greet: 'Developer',
    body:
        'Yo Dev! Hope you are getting positive feedbacks from the fellow users of this app.'
        ' I know you still have some development thing going on in your mind;'
        ' but, it is good to focus on words about your work sometimes.',
    icon: Icons.developer_mode,
  );
  runApp(const MyApp());
}
