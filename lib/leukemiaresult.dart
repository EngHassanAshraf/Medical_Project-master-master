import 'package:flutter/material.dart';
import 'package:medical_project/Models/person.dart';

class LeukemiaResult extends StatefulWidget {
  var result;
  final Person person;
  LeukemiaResult(this.person, {Key? key, required this.result})
      : super(key: key);

  @override
  State<LeukemiaResult> createState() => _LeukemiaResultState();
}

class _LeukemiaResultState extends State<LeukemiaResult> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Center(
            child: Column(
          children: [
            Text(widget.result.toString()),
            IconButton(
              onPressed: () {
                widget.person.isLeukemiaTest = false;
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
          ],
        )),
      ),
    );
  }
}
