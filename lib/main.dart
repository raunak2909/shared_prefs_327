import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var nameController = TextEditingController();
  String name = "";

  @override
  void initState() {
    super.initState();

    ///value fetch
    getValueFromPrefs();

  }

  void getValueFromPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Text(name!="" ? 'Welcome, $name' : ""),
          TextField(
            controller: nameController,
          ),
          ElevatedButton(onPressed: () async{
            ///store the name
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("name", nameController.text);
          }, child: Text('Save'))
        ],
      ),
    );
  }
}
