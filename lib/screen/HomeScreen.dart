import 'package:flutter/material.dart';
import 'package:todoapp/apicall/Apicall.dart';
import 'package:todoapp/common/CustomSnackBar.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List listdata = [];
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController todoNameController = TextEditingController();

  // List<Map> listdata = [
  //   {
  //     "title": "Pallab mondal",
  //     "subtitle": "This is the sub title",
  //     "iscomplact": false,
  //   },
  //   {
  //     "title": "Pallab mondal",
  //     "subtitle": "This is the sub title",
  //     "iscomplact": false,
  //   },
  //   {
  //     "title": "Pallab mondal",
  //     "subtitle": "This is the sub title",
  //     "iscomplact": false,
  //   },
  //   {
  //     "title": "Pallab mondal",
  //     "subtitle": "This is the sub title",
  //     "iscomplact": false,
  //   },
  //   {
  //     "title": "Pallab mondal",
  //     "subtitle": "This is the sub title",
  //     "iscomplact": false,
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    print("initState triggered");
    loadTodo();
  }

  void loadTodo() async {
    try {
      print("Calling API...");
      final data = await Apicall.getTodo();
      print("Received ${data.length} items");
      setState(() {
        listdata = data;
      });
    } catch (e) {
      print("Caught error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Your To-Do List",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade300,
              radius: 20,
              child: Icon(Icons.person, color: Colors.white),
              // backgroundImage:Color(Color.red),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Form(
              key: globalKey,
              child: TextFormField(
                controller: todoNameController,
                validator: (value) {
                  if (value == "" || value == " ") {
                    return "Pls put the tast";
                  }
                },
                decoration: InputDecoration(
                  hintText: "Search tasks...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Today's Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                future: Apicall.getTodo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No tasks found"));
                  } else {
                    final listdata = snapshot.data!;
                    return ListView.separated(
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 12),
                      itemCount: listdata.length,
                      itemBuilder: (context, index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color:
                                listdata[index]['complected']
                                    ? Colors.green.shade100
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              activeColor: Colors.green,
                              value: listdata[index]['complected'] ?? false,
                              onChanged: (value) async {
                                final updatedValue =
                                    !listdata[index]["complected"];
                                final id = listdata[index]["id"];
                                try {
                                  await Apicall.updatetodo(
                                    context: context,
                                    id: id,
                                    iscomplect: updatedValue,
                                    name: listdata[index]["name"],
                                  );
                                  setState(() {
                                    listdata[index]["complected"] =
                                        updatedValue;
                                  });
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Update failed"),
                                    ),
                                  );
                                }
                              },
                            ),
                            title: Text(
                              listdata[index]["name"],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                decoration:
                                    listdata[index]['complected']
                                        ? TextDecoration.lineThrough
                                        : null,
                              ),
                            ),
                            subtitle: Text(
                              listdata[index]['time'],
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                await Apicall.DeleteTodo(
                                  listdata[index]["id"],
                                  context,
                                );
                                setState(() {
                                  listdata.removeAt(index);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CircleAvatar(
        radius: 40,
        backgroundColor: Color(0xFFF5F6FA),
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            if (globalKey.currentState!.validate()) {
              String name = todoNameController.text!;
              Apicall.createTodo(name: name, context: context).then((_) {
                setState(() {
                  todoNameController.text = "";
                });
              });
            } else {
              Customsnackbar.showCustomSnackBar(
                context,
                "Put the data ",
                "error",
              );
            }
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ✅ FIX: Use BottomNavigationBar directly, no BottomAppBar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFDEE9F7),
        elevation: 8,
        currentIndex: 0,
        onTap: (index) {
          // handle tap
        },
        // [Color(0xFFE9F1FA), Color(0xFFDEE9F7)]
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
