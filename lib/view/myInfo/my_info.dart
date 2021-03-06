import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:move_application/models/get_pt_info.dart';
import 'package:move_application/models/get_pt_list.dart';
import 'package:move_application/style/red_container.dart';
import 'package:move_application/view/HomePage.dart';
import 'package:move_application/models/get_reservation_list.dart';
import 'package:move_application/style/text_style.dart';
import 'package:move_application/models/delete_reservation_list.dart';

import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Info extends StatefulWidget{
  @override
  _Info createState() => _Info();
}


class _Info extends State<Info> {
  Future<Null> _onReFresh() async {
    setState(() {});
  }

  late Future<List<Reservation_list>> a;

  @override
  void initState(){
    super.initState();
  }

  static const List<String> _my_reservation = [
    '벤치',
    '파워 렉',
    '레그 익스텐션',
    '레그 익스텐션',
    '레그 익스텐션',
  ];
  static const List<String> _my_class = [
    'awd'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RefreshIndicator(
        onRefresh: _onReFresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.43,
                  width: MediaQuery.of(context).size.width*0.95,
                  margin: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Colors.yellow,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius:30,
                          offset: Offset(5,5),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        BoxShadow(
                          blurRadius:30,
                          offset: Offset(-5,-5),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                              children: [
                                Text('예약 기구',
                                  style:TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                  ),),
                              ],
                            ),
                        ),
                        FutureBuilder<List<Reservation_list>>(
                            future:getReservationList(1234),
                            builder: (context, snapshot) {
                              if (snapshot.hasData == false) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.36,
                                );
                              }
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.36,
                                decoration: BoxDecoration(
                                  color:Colors.white,
                                ),
                                child:ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext _context, int i){
                                    return ListTile(
                                      trailing:
                                      RedRoundedActionButton(text:'취소', callback: () async {
                                        showDialog(context: context, builder: (BuildContext context){
                                          return AlertDialog(
                                            content: Text('예약 취소 하시겠습니까?',textAlign: TextAlign.center,),
                                            title: Text('알림'),
                                            buttonPadding: EdgeInsets.all(10),

                                            actions: [
                                              FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('창 닫기')),
                                              FlatButton(onPressed: () async {
                                                Response response = await deleteReservationList(
                                                    snapshot.data!.elementAt(i).userid, snapshot.data!.elementAt(i).equipment, snapshot.data!.elementAt(i).date);
                                                if(response.statusCode == 200){
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                }
                                              }, child: Text('확인'))
                                            ],
                                          );
                                        });

                                      }, botton_height: 0.007,
                                          botton_width: 0.025, font_size:13,
                                          botton_color: Colors.white12,),
                                      leading: Image.asset(
                                        "icons/${snapshot.data!.elementAt(i).equipment}.jpg",height: 55,),
                                      title: Text(snapshot.data!.elementAt(i).equipment.toString()+'     '+snapshot.data!.elementAt(i).date.toString()),
                                      subtitle: Text(snapshot.data!.elementAt(i).start_time.toString()+' ~ '+snapshot.data!.elementAt(i).end_time.toString(),style:TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: 15.5,
                                      ),),
                                    );
                                  },
                                ) ,
                              );
                            }),

                      ],
                    ),

                  ),

                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02),




                Container(

                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0),
                        child: Row(
                          children: [
                            Text('수업일지',style:TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future : getPtList(1234),
                  builder: (BuildContext context, AsyncSnapshot<List<Pt_history>> snapshot)
                  {
                    if (snapshot.hasData == false) {
                      return Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(

                                child: CircularProgressIndicator(color: Colors.yellow[500],),
                              )
                            ],
                          )
                      );
                    }
                    return Column(
                      children: [
                        snapshot.data!.length == 0
                            ? Container(

                          margin: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('예정된 수업이 없습니다.',textAlign: TextAlign.center,style: TextStyle(fontSize: 21),)
                            ],
                          ),
                        )
                            :Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.yellow,
                            ),
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius:30,
                                offset: Offset(5,5),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              BoxShadow(
                                blurRadius:30,
                                offset: Offset(-5,-5),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext _context, int i){
                              return FutureBuilder(future: getPtInfo(snapshot.data!.elementAt(i).Pkey), builder: (BuildContext context, AsyncSnapshot<List<Pt_Info>> snapshot_Pkey) {
                                return ListTile(
                                  leading: Image.asset(
                                    "icons/${snapshot.data!.elementAt(i).ClassContent}.png",height: 45,),
                                  title: Text(snapshot.data!.elementAt(i).ClassContent+' 운동'),
                                  subtitle: Text(snapshot.data!.elementAt(i).PtDay+' '+snapshot.data!.elementAt(i).StartTime+' ~ ',style: TextStyle(fontSize: 17),),
                                  trailing: RedRoundedActionButton(
                                    text: '상세보기',
                                    callback: (){
                                      showDialog(context: context, builder: (BuildContext context) {

                                        return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:  BorderRadius.all(Radius.circular(12.5)),
                                            ),
                                            actions: [
                                              FlatButton(onPressed: (){

                                                Navigator.pop(context);

                                              }, child: Text('닫기'))
                                            ],
                                          contentPadding: EdgeInsets.only(top: 10.0,bottom: 10),

                                          title: Text('PT 상세내용'),

                                          content: Container(
                                            width: double.minPositive,

                                            child:Column(

                                              mainAxisSize: MainAxisSize.min,
                                              children: [

                                                ListView.builder(

                                                  itemCount: snapshot_Pkey.data!.length, //4
                                                  shrinkWrap: true,
                                                  itemBuilder: (BuildContext context, int index) {

                                                    return ListTile(
                                                      title: Text('운동부위 :'+snapshot_Pkey.data!.elementAt(index).ExserciseContent),
                                                      subtitle: Text('세트 :'+snapshot_Pkey.data!.elementAt(index).Set+'횟수 :'+snapshot_Pkey.data!.elementAt(index).Count),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          )

                                        );
                                      },
                                      );
                                      print(snapshot_Pkey.data!.length);


                                      // for(int z=0;z< snapshot_Pkey.data!.length;z++){
                                      //
                                      //   print('세트 :'+snapshot_Pkey.data!.elementAt(z).Set);
                                      //
                                      //   print('횟수 :'+snapshot_Pkey.data!.elementAt(z).Count);
                                      //
                                      //   print('운동부위 :'+snapshot_Pkey.data!.elementAt(z).ExserciseContent);
                                      //
                                      // }
                                    },
                                      botton_height:0.00001,
                                      botton_width:0.0001,
                                      font_size: 14,
                                      botton_color: Colors.white12
                                  ),

                                );
                              },);

                            },
                          ),
                        ) ,
                      ],
                    );
                  },),
              ],
            ),
          ),
        ),
      )

    );
  }
}