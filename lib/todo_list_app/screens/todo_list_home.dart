import 'package:flutter/material.dart';
import 'package:river_app/todo_list_app/screens/add_todo_screen.dart';
import 'package:river_app/todo_list_app/services/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListHomeScreen extends StatefulWidget {
  const TodoListHomeScreen({super.key});

  @override
  State<TodoListHomeScreen> createState() => _TodoListHomeScreenState();
}

class _TodoListHomeScreenState extends State<TodoListHomeScreen> {

  TextEditingController searchBarCont = TextEditingController();
  SharedPreferenceService? service;
  int count = 0;
  
  List dataList = [];
  @override
  void initState() {
    initSharedPreference();
    SharedPreferenceService.getTodoStatic();


    super.initState();
  }


  initSharedPreference() async{
    final sharedPreference = await SharedPreferences.getInstance();
    service = SharedPreferenceService(sharedPreference);

    dataList = await SharedPreferenceService.getTodoStatic() as List;

  }

  @override
  Widget build(BuildContext context) {
    if(count == 0){
      // SharedPreferenceService.getTodoStatic();
      service?.getTodo();
      count++;
      print('count $count');
    }
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

        body: ui2(),



        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTodoScreen()));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),


      ),
    );
  }


  Widget ui2(){
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: dataList.isNotEmpty?
      ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context ,index) {
            var details = dataList[index];
            return Container(
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
                  Expanded(
                      child:
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          const Icon(Icons.check_circle_outline),
                          const SizedBox(width: 10),
                          Expanded(child: Text('$details',overflow: TextOverflow.ellipsis,)),
                        ],
                      )),
      
                  GestureDetector(
                      onTap: (){},
                      child: const Icon(Icons.delete,color: Colors.red,)
                  )
                ],
              ),
            );
          }
      ):
      Text('empty'),
    );
  }
  Widget ui(){
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: service?.getTodo(),
        // future: SharedPreferenceService.getTodoStatic(),
        builder: (context,snapshot) {
          return ListView.builder(
            itemCount: snapshot.data?.length ??  0,
            itemBuilder: (context ,index) {
              var details = snapshot.data?[index] ?? '';
              return Container(
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
                    Expanded(
                        child:
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(Icons.check_circle_outline),
                            const SizedBox(width: 10),
                            Expanded(child: Text('$details',overflow: TextOverflow.ellipsis,)),
                          ],
                        )),

                    GestureDetector(
                        onTap: (){},
                        child: const Icon(Icons.delete,color: Colors.red,)
                    )
                  ],
                ),
              );
            }
          );
        }
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
