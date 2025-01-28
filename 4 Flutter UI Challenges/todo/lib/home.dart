import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List notes = [
    ["task 1", false],
    ["task 2", false],
  ];
  TextEditingController tilte = TextEditingController();
  Color color = Colors.grey;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (color == Colors.grey) {
                  for (var note in notes) {
                    note[1] = true;
                  }
                  color = const Color.fromARGB(255, 12, 241, 20);
                } else {
                  for (var note in notes) {
                    note[1] = false;
                  }
                  color = Colors.grey;
                }
                setState(() {});
              },
              icon: Icon(
                Icons.done_rounded,
                color: color,
                size: 40,
              )),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Colors.blueAccent,
        title: Text(
          "ToDo",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.blueAccent,
                    content: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Add New Task",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            onEditingComplete: () => setState(() {
                              if (formKey.currentState!.validate()) {
                                notes.add([tilte.text, false]);
                                Navigator.pop(context);
                                tilte.clear();
                              }
                            }),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            controller: tilte,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 22),
                                labelText: "title",
                                border: OutlineInputBorder()),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                  height: 40,
                                  onPressed: () {
                                    setState(() {
                                      if (formKey.currentState!.validate()) {
                                        {
                                          notes.add([tilte.text, false]);
                                          Navigator.pop(context);
                                          tilte.clear();
                                        }
                                      }
                                    });
                                  },
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  )),
                              SizedBox(
                                width: 40,
                              ),
                              MaterialButton(
                                  height: 40,
                                  onPressed: () {
                                    Navigator.pop(context);
                                    tilte.clear();
                                  },
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
        },
        shape: CircleBorder(),
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(
            height: 15,
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) => GestureDetector(
            onLongPress: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        maxLines: 1,
                        notes[index][0],
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    MaterialButton(
                        height: 40,
                        onPressed: () {
                          setState(() {
                            notes.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Remove",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
              ),
            ),
            child: Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent[200]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      notes[index][0],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 26,
                      ),
                    ),
                  ),
                  Checkbox(
                    activeColor: Colors.green,
                    side: BorderSide(color: Colors.white, width: 2),
                    value: notes[index][1],
                    onChanged: (value) {
                      setState(() {
                        notes[index][1] = value;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
