
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:river_app/model/person.dart';
import 'package:dropdown_search/dropdown_search.dart';


class DropDownPractice extends StatefulWidget {
  const DropDownPractice({super.key});

  @override
  State<DropDownPractice> createState() => _DropDownPracticeState();
}

class _DropDownPracticeState extends State<DropDownPractice> {

  List<String> listOfNum = ['One', 'Two', 'Three', 'Four','five','sixsixsix'];
  String? valueNum;

  List<Person> _listOfPerson = [
    Person('name1', 'Flutter', 'email@gmail.com'),
    Person('name2', 'React Native', 'email@gmail.com'),
    Person('name3', 'React Js', 'email@gmail.com'),
    Person('name4', 'Android', 'email@gmail.com'),
  ];
  Person? valuePerson;

  @override
  void initState() {
    super.initState();
    valueNum = listOfNum.first;
    valuePerson = _listOfPerson.first;
  }

  final dropDownKey = GlobalKey<DropdownSearchState>();
  final dropDownKeySearchString = GlobalKey<DropdownSearchState>();

  bool able = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Drop Down Search'),),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
                    
              children: [
            
                
                DropdownSearch<String>.multiSelection(
                  key: dropDownKey,
                  enabled: true,



                  onSaved: (v){},
                  onChanged: (v){},

                  // selectedItem: "Menu",
                  items: (filter, infiniteScrollProps) => listOfNum,


                  decoratorProps: DropDownDecoratorProps(

            
                    baseStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                    ),
            
                    decoration: InputDecoration(


                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Hint: multiselection ',
                      hintStyle: TextStyle(
                        color:Colors.blueGrey
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0)
                    ),
                  ),
                  popupProps: PopupPropsMultiSelection.dialog(

                    title: Container(
                      decoration: BoxDecoration(color: Colors.blue),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Numbers 1..30',
                        style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                    ),
            
                    showSearchBox: true,
                    searchDelay: Duration(milliseconds: 200),
                    searchFieldProps: TextFieldProps(
                      padding:  EdgeInsets.all(10),
                      style: TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        focusedBorder: getBorder(borderColor: Colors.white),
                        enabledBorder: getBorder(borderColor: Colors.white),
                      )
                    ),
            
            
                    dialogProps: DialogProps(
                      insetPadding: EdgeInsets.only(top: 20,left: 28,right: 28),
                      backgroundColor: Colors.blue,
                      contentPadding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(),

                    ),

                    checkBoxBuilder: (context , s ,t,selected){

                      return selected? Icon(Icons.check_box_outlined,color: Colors.white,)
                          :Icon(Icons.square_outlined,color: Colors.white,);
                  },

                    itemBuilder: (context, item, isDisabled, isSelected) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          item,
                          style: TextStyle(color: Colors.white, fontSize: 18)
                      ),
                    ),


                  ),



                  dropdownBuilder: (context, selectedItem) {

                    return Wrap(
                      spacing: 8.0,
                      children: selectedItem.map((item) {
                        return Chip(
                          padding: EdgeInsets.only(left: 6),
                          label: Row(
                            mainAxisSize:MainAxisSize.min,
                            children: [
                              Text(item),
                              InkWell(
                                onTap: (){

                                  List<String> updatedList = List.from(selectedItem);
                                  updatedList.remove(item);


                                  dropDownKey.currentState?.clear();


                                },
                                child: Icon(Icons.clear,size: 20,),
                              )
                            ],
                          ), // Display each item separately
                          backgroundColor: Colors.blue.shade100,
                          labelStyle: TextStyle(color: Colors.black),
                        );
                      }).toList(),
                    );
                  },


                ),

                Stack(
                  children: [
                    InkWell(
                      onTap: (){
                        dropDownKey.currentState?.closeDropDownSearch();
                        showAdaptiveDialog(context: context,
                            builder: (BuildContext c){
                              return AlertDialog(title: Text('beta'),);
                            });
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: InkWell(
                            onTap: (){
                              showAdaptiveDialog(context: context,
                                  builder: (BuildContext c){
                                      return AlertDialog(title: Text('data'),);
                                  });

                            },
                            child: Container(
                              height: 20,
                              width: 20,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )


                    
                    
              ],
            ),
          ),
        ),
      ),

    );
  }

  InputBorder getBorder({
    Color borderColor =Colors.transparent
}){
    return OutlineInputBorder(
        borderSide: BorderSide(color: borderColor)
    );
  }

  getDropDownString(){
    return DropdownButton<String>(
      value: valueNum,
      onChanged: (value){
        setState(() {
          valueNum = value!;
        });
      },
      items: listOfNum.map((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),

    );
  }

  getDropDownPerson(){
    return DropdownButton(
      value: valuePerson,
      onChanged: (Person? value){
        setState(() {
          valuePerson = value;
        });
      },
      dropdownColor: Colors.blue,
      items: _listOfPerson.map((Person value){
        return DropdownMenuItem<Person>(
          value: value,
          child: Text(value.name,style: TextStyle(
              color: Colors.white
          ),),
        );
      }).toList(),
    );
  }

  getDropDownSearchString(){
    return DropdownSearch<String>(
      key: dropDownKeySearchString,
      enabled: true,
      onSaved: (v){},
      onChanged: (v){},
      // selectedItem: "Menu",
      // mode: Mode.custom,
      items: (filter, infiniteScrollProps) => listOfNum,
      // dropdownBuilder: (ctx, selectedItem) => Icon(Icons.calendar_month_outlined, size: 54),
      decoratorProps: DropDownDecoratorProps(

        baseStyle: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),

        decoration: InputDecoration(

            filled: true,
            fillColor: Colors.white,
            hintText: 'This is Hint',
            hintStyle: TextStyle(
                color:Colors.blueGrey
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0)
        ),
      ),
      popupProps: PopupProps.dialog(
          showSelectedItems: true,
          searchDelay: Duration(milliseconds: 200),
          searchFieldProps: TextFieldProps(
          ),

          dialogProps: DialogProps(
            backgroundColor: Colors.blue,
            actionsPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [

              ElevatedButton(
                  onPressed: (){

                  },
                  child: Text('Submit')
              ),
              ElevatedButton(
                  onPressed: (){

                  },
                  child: Text('Clear')
              )
            ],

          )
      ),
    );
  }

}

