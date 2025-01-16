import 'dart:isolate';
import 'package:action_slider/action_slider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:prosam/views/example.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/gifs/bouncing-ball.gif'),
              //Blocking UI task
              ElevatedButton(
                onPressed: () async {
                  var total = await complexTask1();
                  debugPrint('Result 1: $total');
                },
                child: const Text('Task 1'),
              ),
              //Isolate
              ElevatedButton(
                onPressed: () async {
                  final receivePort = ReceivePort();
                  await Isolate.spawn(complexTask2, receivePort.sendPort);
                  receivePort.listen((total) {
                    debugPrint('Result 2: $total');
                  });
                },
                child: const Text('Task 2'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Task 3'),
              ),

              ActionSlider.standard(
                sliderBehavior: SliderBehavior.stretch,
                width: 300.0,
                backgroundColor: Colors.white,
                toggleColor: Colors.lightGreenAccent,
                action: (controller) async {
                  controller.loading();  
                  await Future.delayed(const Duration(seconds: 3));
                  controller.success();  
                  await Future.delayed(const Duration(seconds: 1));
                  controller.reset();   
                },
                child: const Text('Slide to confirm'),
              ),

              ExpandablePageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Example();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<double> complexTask1() async {
    var total = 0.0;
    for (var i = 0; i < 1000000000; i++) {
      total += i;
    }
    return total;
  }
}
//--End of HomePage--

complexTask2(SendPort sendPort) {
  var total = 0.0;
  for (var i = 0; i < 1000000000; i++) {
    total += i;
  }
  sendPort.send(total);
}
