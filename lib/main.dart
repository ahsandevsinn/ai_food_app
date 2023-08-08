import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Controller/provider/login_provider.dart';
import 'package:ai_food/Practice/article_provider.dart';
import 'package:ai_food/Practice/list_management_provider.dart';
import 'package:ai_food/Practice/practice_ui.dart';
import 'package:ai_food/Practice/provider_practice.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<PracticeProvider>(create: (_) => PracticeProvider()),
        ChangeNotifierProvider<ListManagementProvider>(create: (_) => ListManagementProvider()),
        ChangeNotifierProvider<ArticleProvider>(create: (_) => ArticleProvider()),
      ],
      child: MaterialApp(
        title: 'AIFood',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'AIFood'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;
  AppLogger logger = AppLogger();

  @override
  void initState() {
    logger.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(builder: (context) {
        var myLoginProvider = context.watch<LoginProvider>();
        return myLoginProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const AppText(
                        'You have pushed the button this many times:'),
                    AppText('$_counter', size: 36),
                    const SizedBox(height: 50),
                    AppText(
                      'Practice UI',
                      size: 36,
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) => const PracticeUI()));
                      },
                    ),
                  ],
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ApiManager.loginUser(context,
          //     email: "vendor1122@gmail.com", password: "123456");
          var myLoginProvider = context.read<LoginProvider>();
          await myLoginProvider.login(context,
              email: "vendor1122@gmail.com", password: "123456");
          // print("getttomg_data ${myLoginProvider.responseData!["data"]["user"]["email"]}");
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
