import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:scoped_provider_example/button_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScopedProvider example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Material(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ProviderScope(
              overrides: [
                buttonStateScopedProvider.overrideAs(
                  (watch) => watch(buttonNotifierProvider(index)),
                ),
                buttonNotifierScopedProvider.overrideAs(
                  (watch) => watch(buttonNotifierProvider(index).notifier),
                ),
              ],
              child: const MyButton(),
            );
          },
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.read(buttonNotifierScopedProvider).onTap,
      child: Container(
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        padding: const EdgeInsets.all(30),
        alignment: Alignment.center,
        child: HookBuilder(
          builder: (context) {
            final state = useProvider(buttonStateScopedProvider);
            return Text(
              state.tapsNumber,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
