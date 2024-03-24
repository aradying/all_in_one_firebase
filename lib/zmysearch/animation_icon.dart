import 'package:flutter/material.dart';

class ColoAn extends StatefulWidget {
    const ColoAn({super.key});

    @override
    State<ColoAn> createState() => _ColoAnState();
}
class _ColoAnState extends State<ColoAn> with SingleTickerProviderStateMixin {
    late AnimationController controller;
    late Animation animation;

    @override
  void initState() {
        super.initState();

        controller = AnimationController(
            duration: const Duration(milliseconds: 200), //controll animation duration
            vsync: this,
        )..addListener(() {
            setState(() {});
        });

        animation = ColorTween(
            begin: Colors.grey,
            end: Colors.red,
        ).animate(controller);
    }


    @override
  void dispose() {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Center(
                child: Icon(
                    Icons.favorite,
                    color: animation.value,
                ),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
                if (controller.value == 1) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
            }),
        );
    }
}
