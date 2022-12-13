import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class registertitle extends StatelessWidget {
  const registertitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35))),
          child: Center(
            child: Image.asset(
              'lib/images/clock.gif',
              height: 90,
              width: 90,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ));
  }
}
