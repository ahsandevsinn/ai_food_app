import 'package:ai_food/Constants/app_logger.dart';
import 'package:ai_food/Utils/resources/res/app_theme.dart';
import 'package:ai_food/Utils/utils.dart';
import 'package:ai_food/Utils/widgets/others/app_button.dart';
import 'package:ai_food/Utils/widgets/others/app_text.dart';
import 'package:ai_food/View/HomeScreen/home_screen.dart';
import 'package:ai_food/View/HomeScreen/recipe_params_screen.dart';
import 'package:ai_food/View/NavigationBar/bottom_navigation.dart';
import 'package:ai_food/config/app_urls.dart';
import 'package:ai_food/config/dio/app_dio.dart';
import 'package:ai_food/config/dio/spoonacular_app_dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController _searchController = TextEditingController();
  late AppDio dio;
  late SpoonAcularAppDio spoonDio;

  AppLogger logger = AppLogger();
  bool isLoading = false;

  @override
  void initState() {
    dio = AppDio(context);
    spoonDio = SpoonAcularAppDio(context);

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
        toolbarHeight: 65,
        leadingWidth: 60,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              top: 20,
            ),
            child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                    color: AppTheme.appColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.arrow_back_ios,
                      size: 25, color: AppTheme.whiteColor),
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
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 15),
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
                              onFieldSubmitted: (value) {
                                print("search_value $value");
                                getFood(context);
                              },
                              textInputAction: TextInputAction.search,
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
                            FocusScope.of(context).requestFocus(FocusNode());
                            getFood(context);
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 60,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFB38ADE),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                                  child: SvgPicture.asset("assets/images/Search.svg",
                                      width: 30, height: 30),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 3.0),
                                    child: Icon(
                                      Icons.filter_list,
                                      color: Color(0xFFF7F7F7),
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

  Future<void> getFood(context) async {
    // Set isLoading to true when the API call starts
    setState(() {
      isLoading = true;
    });

    var searchtext = _searchController.text;
    // const apiKey = '6fee21631c5c432dba9b34b9070a2d31';
    const apiKey = '56806fa3f874403c8794d4b7e491c937';

    final apiUrl =
        '${AppUrls.spoonacularBaseUrl}/recipes/complexSearch?query=$searchtext&apiKey=$apiKey';

    try {
      final response = await spoonDio.get(path: apiUrl);

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

        // _searchController.clear();
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
