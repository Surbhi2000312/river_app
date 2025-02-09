import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class PracticeToastSnack extends StatefulWidget {
  const PracticeToastSnack({super.key});

  @override
  State<PracticeToastSnack> createState() => _PracticeToastSnackState();
}

class _PracticeToastSnackState extends State<PracticeToastSnack>
with SingleTickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController snackController;

  FToast? fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);

    // for snack
    snackController = AnimationController(
      duration: Duration(milliseconds:  500),
      vsync: this,
    );
    animation = CurvedAnimation(parent: snackController, curve: Curves.ease)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed){
          snackController.reverse();
        }
      });
  }
  @override
  void dispose() {
    snackController.dispose();
    super.dispose();
  }
  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast!.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );

  }

  _showToast2() {
    Widget toastContent = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );

    fToast!.showToast(
        child: toastContent,
        toastDuration: Duration(seconds: 1), // coming
        fadeDuration: Duration(seconds: 1), // going
        gravity: ToastGravity.CENTER
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('toast and snacks'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            ElevatedButton(onPressed: (){
              showToast1();
              // _showToast2();
            }, child: Text('toast')),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              // showToast1();
              showSnack();
            }, child: Text('snack')),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              // showToast1();
              showSnack2();
            }, child: Text('snack2')),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: (){
            // _showToast();
            Fluttertoast.cancel();
          },
        child: Icon(Icons.clear),

      ),
    );
  }

  void showToast1() => Fluttertoast.showToast(
    msg: 'Flutter toast Message is working',
    gravity: ToastGravity.CENTER,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: Colors.white,
    textColor: Colors.blueAccent,
    fontSize: 16.0,
  );

  void showSnack(){
    // https://flutter31222000.blogspot.com/2025/02/flutter-toast-and-snackbar.html

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          animation: animation,
          content: FadeTransition(
            opacity: snackController,
            child: Text('Yay! A SnackBar!',style: TextStyle(color: Colors.white),),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          duration: Duration(milliseconds: 700),
          // behavior: SnackBarBehavior.floating,
          // behavior: SnackBarBehavior.fixed, // default behavior
        )
    );
  }

  void showSnack2(){
    SnackBar snackBar = SnackBar(
      animation: animation,
      content: Text('Yay! A SnackBar!'),
      duration: Duration(milliseconds: 2000),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }


}


