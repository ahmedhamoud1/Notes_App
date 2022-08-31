import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/cubit/cubit.dart';
import 'package:notes/cubit/states.dart';
import 'package:url_launcher/link.dart';

import '../components/component.dart';

class Home extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {
          if (state is InsertToDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, state) {
          var note = AppCubit.get(context).notes;
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Text(
                'Notes App',
                style: GoogleFonts.acme(
                  color: Colors.teal,
                  fontSize: 25,
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.error,
                  color: Colors.teal,
                  size: 24,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Note'),
                                  titleTextStyle: GoogleFonts.acme(
                                      color: Colors.teal, fontSize: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  content: Form(
                                    key: formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          onTap: (){},
                                          controller: titleController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                      color: Colors.teal)),
                                              prefixIcon: Icon(
                                                Icons.drive_file_rename_outline,
                                                color: Colors.teal,
                                              ),
                                              labelText: 'Write Notes Here',
                                              labelStyle: GoogleFonts.acme(
                                                  fontSize: 15,
                                                  color: Colors.teal)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.InsertToDatabase(
                                            title: titleController.text,
                                          );
                                        }
                                      },
                                      child: Text(
                                        "Add",
                                        style: GoogleFonts.acme(
                                            color: Colors.teal, fontSize: 19),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: GoogleFonts.acme(
                                            color: Colors.teal, fontSize: 19),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                      icon: Icon(
                        Icons.drive_file_rename_outline,
                        size: 29,
                        color: Colors.teal,
                      )),
                )
              ],
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Image(
                          image: AssetImage('images/2.png'),
                        )),
                    Text(
                      'For technical support contact us',
                      style: GoogleFonts.acme(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(Icons.link),
                        SizedBox(
                          width: 40,
                        ),
                        Link(
                          uri: Uri.parse(
                              'https://www.linkedin.com/in/ahmed-hamoud-8b0041217/'),
                          target: LinkTarget.self,
                          builder: (context, followLink) => ElevatedButton(
                            child: Text(
                              'Linked In',
                              style: GoogleFonts.acme(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            onPressed: followLink,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: ConditionalBuilder(
                condition: note.length > 0,
                builder: (context) => ListView.separated(
                      itemCount: note.length,
                      itemBuilder: (context, index) =>
                          BuildNoteItem(note[index], context),
                      separatorBuilder: (context, index) => SizedBox(),
                    ),
                fallback: (BuildContext context) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('images/1.png')),
                  ),
                )),
          );
        },
      ),
    );
  }
}
