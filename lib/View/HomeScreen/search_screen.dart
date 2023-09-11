import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/home_screen.dart';
import 'package:ai_food/View/HomeScreen/recipe_params_screen.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _searchController = TextEditingController();
  late AppDio dio;
  AppLogger logger = AppLogger();
  bool isLoading = false;

  @override
  void initState() {
    dio = AppDio(context);
    logger.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 10,
              top: 10,
            ),
            child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: AppTheme.appColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_back_ios,
                      size: 20, color: AppTheme.whiteColor),
                )),
          ),
        ),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: AppTheme.appColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xffd9c4ef),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            width: width * 0.65,
                            child: TextFormField(
                              controller: _searchController,
                              autofocus: true,
                              cursorColor: AppTheme.appColor,
                              style: TextStyle(color: AppTheme.appColor),
                              decoration: InputDecoration.collapsed(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: AppTheme.whiteColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a recipe';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _autoValidateMode = AutovalidateMode.disabled;
                                });
                              },
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            getFood();
                          },
                          child: Container(
                            width: 60,
                            height: 50,
                            decoration: const BoxDecoration(
                              color: Color(0xffb38ade),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(100),
                                  bottomRight: Radius.circular(100)),
                            ),
                            child: const Icon(
                              Icons.search_outlined,
                              size: 35,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          pushReplacement(context, const RecipeParamScreen());
                        },
                        child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppTheme.appColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom:3.0),
                                    child: Icon(
                                      Icons.filter_list,
                                      color: AppTheme.whiteColor,
                                      size: 22,
                                    ),
                                  ),
                                  AppText.appText(
                                    "Advanced search",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    textColor: AppTheme.whiteColor,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  // Define a boolean variable to track the loading state

  Future<void> getFood() async {
    // Set isLoading to true when the API call starts
    setState(() {
      isLoading = true;
    });

    var searchtext = _searchController.text;
    const apiKey = 'd9186e5f351240e094658382be62d948';

    final apiUrl =
        'https://api.spoonacular.com/recipes/complexSearch?query=$searchtext&apiKey=$apiKey';

    try {
      final response = await dio.get(path: apiUrl);

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        pushReplacement(
          context,
          BottomNavView(
            searchType: 0,
            type: 1,
            data: response.data["results"],
            query: searchtext,
            offset: response.data["offset"],
          ),
        );

        _searchController.clear();
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      print('API request failed with error: $error');
    } finally {
      // Set isLoading to false when the API call completes (success or failure)
    }
  }
}
