import 'package:flutter/material.dart';
import 'package:river_app/todo_list_app/services/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController searchBarCont = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SharedPreferenceService? service;
  initSharedPreference() async{
    final sharedPreference = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.indigo, // Set primary color to indigo
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // Set app bar color
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black, // Set button color
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black)
        ),
      ),
      child: Scaffold(

        appBar: appBar(),

        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Colors.blue
                  ),
                ),
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                height: 60,
                child: Row(

                  children: [
                    Expanded(child: Row(

                      children: [
                        const SizedBox(width: 10),
                        Icon(Icons.check_circle_outline),
                        const SizedBox(width: 10),
                        Expanded(child: Text('Go to Gym',overflow: TextOverflow.ellipsis,)),
                      ],
                    )),
                    GestureDetector(
                      onTap: (){},
                        child: const Icon(Icons.delete,color: Colors.red,)
                    )
                  ],
                ),
              ),
            ],
          ),
        ),



        floatingActionButton: FloatingActionButton(onPressed: (){

        },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),


      ),
    );
  }

  AppBar appBar(){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:  BorderRadius.circular(10),
            border: Border.all(
                width: 1,
                color: Colors.blue
            )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search,color: Colors.blue,size: 22),
            Expanded(
              child: TextField(
                textInputAction: TextInputAction.search,
                maxLines: 1,
                controller: searchBarCont,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  contentPadding: EdgeInsets.only(left: 0,bottom: 2),
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                  isDense: true,
                ),
                obscureText: false,
                style: const TextStyle(fontSize: 18,color: Colors.black),
                cursorColor: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
