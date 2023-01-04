import 'dart:async';

import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: myclock(),));
}

class myclock extends StatefulWidget {
  const myclock({Key? key}) : super(key: key);

  @override
  State<myclock> createState() => _myclockState();
}

class _myclockState extends State<myclock> {
int seconds = 0,minutes = 0,hours = 0;
String digitSeconds = "00",digitMinutes = "00", digitHours = "00";
Timer? timer;
bool started = false;
List laps =[];

void stop(){
  timer!.cancel();
  setState(() {
    started = false;
  });
}

void reset(){
  timer!.cancel();
  setState(() {
    seconds = 0;
    minutes = 0;
    hours = 0;

    digitSeconds = "00";
    digitMinutes = "00";
    digitHours = "00";

    started = false;
  });
}

void addLaps(){
  String lap = "$digitHours:$digitMinutes:$digitSeconds";
  setState(() {
    laps.add(lap);
  });
}

void start(){
  started = true;
  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    int localSeconds = seconds + 1;
    int localMinutes = minutes;
    int localHours = hours;

    if(localSeconds > 59){
      if(localMinutes > 59){
        localHours++;
        localMinutes = 0;
      }else{
        localMinutes++;
        localSeconds = 0;
      }
    }
    setState(() {
      seconds = localSeconds;
      minutes = localMinutes;
      hours = localHours;
      digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
      digitHours = (hours >= 10) ? "$hours" : "0$hours";
      digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1c2757),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text("StopWatch App",style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.w500,letterSpacing: 3),),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text("$digitHours:$digitMinutes:$digitSeconds",style: TextStyle(color: Colors.white,fontSize: 82,fontWeight: FontWeight.w300),),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Color(0xff323F68),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Lap ${index + 1}",style: TextStyle(color: Colors.white,fontSize: 16),),
                            Text("${laps[index]}",style: TextStyle(color: Colors.white,fontSize: 16),),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      (!started) ? start() : stop();
                    },
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        //color: Colors.black54,
                        border: Border.all(width: 3),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(child: Text((started!) ? "Pause" : "Start",
                        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300,letterSpacing: 4),)),
                    ),
                  ),
                  SizedBox(width: 8,),
                  IconButton(color: Colors.white,onPressed: (){
                    addLaps();
                  }, icon: Icon(Icons.flag_outlined),),
                  SizedBox(width: 8,),
                  InkWell(
                    onTap: (){
                      reset();
                    },
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                          //color: Colors.black54,
                          border: Border.all(width: 3),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(child: Text("Reset",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w300,letterSpacing: 4),)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
