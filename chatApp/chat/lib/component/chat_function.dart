import 'package:flutter/material.dart';

import 'const.dart';
import 'function.dart';

buildContainerSender({required var list})
{
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: const EdgeInsets.all(8),
      //alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 15),
      decoration:  BoxDecoration(
          borderRadius:const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
          color: colorApp
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(list,
          style: myTextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),

        ),
      ),
    ),
  );
}

buildContainerReceiver({required var list})
{
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.all(8),
      //alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          color: Color(0xff006D84)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(list,
          style: myTextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal),

        ),
      ),
    ),
  );
}