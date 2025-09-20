import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _imagePath;
  String? _selectedEmail;
  final List<String> _emails = [
    'delivery1@example.com',
    'delivery2@example.com',
    'delivery3@example.com',
  ];

  Future<void> _takePicture() async {
    // TODO: Implement image capture using image_picker or camera
    // For now, just mock the image path
    setState(() {
      _imagePath = 'mock_image_path.jpg';
    });
  }

  Future<void> _sendEmail() async {
    // TODO: Implement email sending using mailer package
    // For now, just mock sending
    if (_imagePath != null && _selectedEmail != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sent $_imagePath to $_selectedEmail')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Delivery Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera_alt),
              label: const Text('Take Picture'),
              onPressed: _takePicture,
            ),
            const SizedBox(height: 16),
            if (_imagePath != null)
              Column(
                children: [
                  // Placeholder for image preview
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(child: Text('Image Preview')),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            DropdownButton<String>(
              hint: const Text('Select Email'),
              value: _selectedEmail,
              items: _emails.map((email) {
                return DropdownMenuItem(
                  value: email,
                  child: Text(email),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedEmail = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.send),
              label: const Text('Send'),
              onPressed: (_imagePath != null && _selectedEmail != null)
                  ? _sendEmail
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
