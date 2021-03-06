import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:move_application/view/appbar.dart';
import 'package:move_application/view/board/board_category.dart';
import 'package:move_application/view/home/home.dart';
import 'package:move_application/view/reservation/reservation.dart';
import 'package:move_application/view/myInfo/my_info.dart';
import 'package:move_application/style/text_style.dart';
import 'package:move_application/view/appbar.dart';
import 'end_drawer.dart';

class HomePage extends StatefulWidget {
  final String access_token;
  String ID;

  HomePage({required this.access_token, required this.ID});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late String id = widget.ID;



  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(child:
    Scaffold(
      key: _scaffoldkey,
      endDrawer: CustomEndDrawer(),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height*0.095,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'images/logo.png',
              fit:BoxFit.contain,
              height:44,
              width:55,
            ),
            Text(
              '비켜',
              style: TextStyle(color: Colors.black,
                  fontSize: 25,
                  letterSpacing: 1.8,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _scaffoldkey.currentState!.openEndDrawer();
            },
            icon: Image.asset(
              'images/bell.png',
              color:Colors.black,
            ),
          )
        ],
        centerTitle: false,
        backgroundColor: Colors.white,
        shadowColor: null,
        elevation: 0.0,
      ),
      body: [home(ID:id),Reservation(),BoardCategory(),Info()][selectedPage],
      bottomNavigationBar: ConvexAppBar(
        initialActiveIndex:0,
        backgroundColor: Colors.white,
        color: Colors.yellow[500],
        activeColor: Colors.white,
        elevation: 3,
        curveSize: 150,// 동그라미를 감싸는 커브 각도
        top: 0,// 동그라미 사이즈
        height: MediaQuery.of(context).size.height*0.075,// 탭 높이
        items: [
          TabItem(
            icon: Image.asset(
              "icons/homepage-icons/home.png",
              color: Colors.grey[500],
              scale: 6,
            ),activeIcon: Image.asset(
            "icons/homepage-icons/home.png",
            color: Colors.yellow,
            scale: 6.1,
          ),

          ),
          TabItem(
              icon: Image.asset(
                "icons/homepage-icons/timetable.png",
                color: Colors.grey[500],
                scale: 6,
              ),activeIcon: Image.asset(
            "icons/homepage-icons/timetable.png",
            color: Colors.yellow,
            scale: 6.1,)
          ),
          TabItem(
              icon: Image.asset(
                "icons/homepage-icons/meeting.png",
                color: Colors.grey[500],
                scale:6,
              ),activeIcon: Image.asset(
            "icons/homepage-icons/meeting.png",
            color: Colors.yellow,
            scale: 6.1,)
          ),
          TabItem(icon: Image.asset(
            'images/human.png',
            color: Colors.grey[500],
          ),activeIcon: Image.asset(
            'images/human.png',
            color: Colors.yellow,
            scale: 6.1,
          )),

        ],
        onTap: (int index){
          setState(() {
            selectedPage = index;
          });
        },
      ),
    ), onWillPop: (){
      //뒤로가기 막기
      return Future(()=>false);
    }) ;
  }
}
