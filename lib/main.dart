import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/themeManager.dart';
import 'screens/doneList.dart';
import 'screens/doList.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeManager(), // Provide the ThemeManager to the app
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeManager.themeMode, // Use themeMode from ThemeManager
      home: homePage(),
    );
  }
}

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(
              themeManager.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              themeManager.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        // Centers the entire content
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Centered Clock
            StreamBuilder<DateTime>(
              stream: Stream.periodic(
                  const Duration(seconds: 1), (_) => DateTime.now()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final currentTime = snapshot.data!;
                  return Text(
                    _formatTime(currentTime),
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.bold),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            const SizedBox(height: 32), // Space before buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => doList()),
                );
              },
              child: const Text('Do List'),
            ),
            const SizedBox(height: 16), // Adds space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => doneList()),
                );
              },
              child: const Text('Done List'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to format time
  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}:'
        '${dateTime.second.toString().padLeft(2, '0')}';
  }
}
