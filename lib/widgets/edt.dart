import 'package:flutter/material.dart';

class Edt extends StatelessWidget {
  const Edt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.check_circle),
          title: Text("Todos"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              TextFormField(
                decoration: InputDecoration(
                  // filled: true,
                  fillColor: Colors.indigoAccent,

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 5, color: Colors.indigoAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(width: 5, color: Colors.indigoAccent),
                  ),

                  // labelText: "Enter Todo",
                  // labelStyle:
                  hintText: "Enter todo",
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(.6),
                      fontSize: 20,
                    fontWeight: FontWeight.normal
                  ),


                ),
              ),
            ],
          ),
        ),
    );
  }
}
