import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter FlashLight',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool turnOnOff = false;

  void _switch() {
    if (turnOnOff) {
      _turnOffFlash(context);
    } else {
      _turnOnFlash(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: turnOnOff ? Colors.white : Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton.large(onPressed: _switch, child: turnOnOff ? const Icon(Icons.flashlight_on_rounded, color: Colors.white,) : const Icon(Icons.flashlight_off_rounded),
            backgroundColor: turnOnOff ? Colors.black : Colors.white,)
          ],
        ),
      ),
    );
  }

  Future<void> _turnOnFlash(BuildContext context) async {
    try {
      await TorchLight.enableTorch();
      setState(() {
        turnOnOff = !turnOnOff;
      });
    } on Exception catch(_) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.warning_rounded, color: Colors.red,),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Failed to turn on flashlight', textAlign: TextAlign.center,)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: () {Navigator.pop(context);}, child: const Text("OK"))
          ],
        );
      });
    }
  }

  Future<void> _turnOffFlash(BuildContext context) async {
    try {
      await TorchLight.disableTorch();
      setState(() {
        turnOnOff = !turnOnOff;
      });
    } on Exception catch(_) {
      showDialog(context: context, builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(Icons.warning_rounded, color: Colors.red,),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Failed to turn off flashlight.', textAlign: TextAlign.center,)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                }
            )
          ],
        );
      });
    }
  }
}

