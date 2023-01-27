import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_hive/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // /data/user/0/com.example.test_hive/cache
  final tmp = await getTemporaryDirectory();
  Hive
    ..init(tmp.path)
    ..registerAdapter(PersonAdapter())
    ..registerAdapter(AddressAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

const persons = [
  Person(
      name: 'Alex',
      age: 22,
      address: Address(
        street: 's1',
        house: 1,
      )),
  Person(
      name: 'Ben',
      age: 33,
      address: Address(
        street: 's2',
        house: 2,
      )),
];

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Some title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                var box = await Hive.openBox('testBox');
                await box.put('asdf', persons);
              },
            ),
            ElevatedButton(
              child: const Text('Load'),
              onPressed: () async {
                var box = await Hive.openBox('testBox');
                box.values;
                box.clear();
                print(box.get('asdf')); // Dave: 22
              },
            ),
          ],
        ),
      ),
    );
  }
}
