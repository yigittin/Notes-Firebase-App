import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/pages/addnote.dart';
import 'package:notes_app/pages/viewnote.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('notes');

  List<Color> myColors = [
    Color(0xfffff59D),
    Color(0xffef9a9a),
    Color(0xffa5d6a7),
    Color(0xffb39ddb),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => AddNote(),
              ),
            )
                .then((value) {
              setState(() {});
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.white70,
          ),
          backgroundColor: Colors.grey[700],
        ),
        appBar: AppBar(
          title: Text(
            'Notes',
            style: TextStyle(
              fontSize: 32.0,
              fontFamily: "lato",
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          elevation: 0.0,
          backgroundColor: Color(0xff070706),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Random random = new Random();
                    Color bg = myColors[random.nextInt(4)];

                    Map data = snapshot.data!.docs[index].data() as Map;
                    DateTime mydateTime = data['created'].toDate();
                    String formatTime =
                        DateFormat.yMMMd().add_jm().format(mydateTime);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => ViewNote(data, formatTime,
                                snapshot.data!.docs[index].reference),
                          ),
                        )
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Card(
                        color: bg,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data['title']}",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: "lato",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  DateFormat.yMMMd()
                                      .add_jm()
                                      .format(mydateTime),
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "lato",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('Loading'),
              );
            }
          },
        ));
  }
}
