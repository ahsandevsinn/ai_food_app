import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Controller/provider/login_provider.dart';
import 'package:ai_food/Practice/article_provider.dart';
import 'package:ai_food/Practice/books_provider.dart';
import 'package:ai_food/Practice/list_management_provider.dart';
import 'package:ai_food/Practice/practice_ui.dart';
import 'package:ai_food/Practice/provider_practice.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/spoonacular/providers/RecipiesParameterProvider.dart';
import 'package:ai_food/spoonacular/recipies.dart';
import 'package:ai_food/spoonacular/screens/bottom_nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  AppLogger logger = AppLogger();
  logger.init();
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
        ChangeNotifierProvider<Books>(create: (_) => Books()),
        ChangeNotifierProvider<RecipesParameterProvider>(create: (_) => RecipesParameterProvider()),
        ChangeNotifierProvider<ProteinProvider>(create: (_) => ProteinProvider()),
        ChangeNotifierProvider<StyleProvider>(create: (_) => StyleProvider()),
        ChangeNotifierProvider<AllergiesProvider>(create: (_) => AllergiesProvider()),
        ChangeNotifierProvider<ChatBotProvider>(create: (_) => ChatBotProvider()),
      ],
      child: MaterialApp(
        title: 'AIFood',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const MyHomePage(title: 'AIFood'),
        home: BottomNavView(),
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
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,
                CupertinoPageRoute(builder: (_) => const Recipies()));
          }, icon: const Icon(Icons.navigate_next_sharp))
        ],
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
