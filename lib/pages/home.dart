

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employee/core.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController locationcontroller = new TextEditingController();

  Stream? EmployeeStream;

  getontheload() async {
    EmployeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
        stream: EmployeeStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name:" + ds["Name"],
                                      style: TextStyle(
                                          color: Colors.green[400],
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          namecontroller.text = ds["Name"];
                                          agecontroller.text = ds["age"];
                                          locationcontroller.text =
                                              ds["location"];
                                          EditEmployeeDetail(ds["Id"]);
                                        },
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.orange[600],
                                        )),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await DatabaseMethods()
                                            .deleteEmployeeDetail(ds["Id"]);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.orange[600],
                                      ),
                                    )
                                  ],
                                ),
                                Text(
                                  "age: " + ds["age"],
                                  style: TextStyle(
                                      color: Colors.amber[800],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "location: " + ds["location"],
                                  style: TextStyle(
                                      color: Colors.green[400],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Employee()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
          title: Row(
        children: [
          Text(
            "Data Employee",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),
          )
        ],
      )),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }

  Future EditEmployeeDetail(String id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel)),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(
                            color: Colors.amber[800],
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Details",
                        style: TextStyle(
                            color: Colors.green[400],
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: locationcontroller,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                Map<String, dynamic> UpdateInfo = {
                                  "Name": namecontroller.text,
                                  "Age": agecontroller.text,
                                  "Id": id,
                                  "Location": locationcontroller.text
                                };
                                await DatabaseMethods()
                                    .updateEmployeeDetail(id, UpdateInfo)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              },
                              child: Text("Update")))
                    ],
                  )
                ],
              ),
            ),
          ));
}
