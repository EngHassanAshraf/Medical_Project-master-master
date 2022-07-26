import 'dart:convert';

import 'package:flutter/material.dart';

import 'Models/drawer.dart';
import 'Models/person.dart';

class AnimiaCovidResult extends StatefulWidget {
  final Person person;
  // var covidanimiaresult;
  AnimiaCovidResult(this.person, {Key? key, })
      : super(key: key);

  @override
  State<AnimiaCovidResult> createState() => _AnimiaCovidResultState();
}

class _AnimiaCovidResultState extends State<AnimiaCovidResult> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DefaultDrawer(),
      appBar: AppBar(title: Text('Anima&Covid Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.person.hasAnimea?'Anemia Found' :'No Anemia found'),
            Text(widget.person.hasCovid?'Covid Found':'No Covid Found'),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                // widget.person.isOCRTest = false;
              },
              child: Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}
