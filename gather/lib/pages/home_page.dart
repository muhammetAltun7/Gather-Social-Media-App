import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gather/components/gather_post.dart';
import 'package:gather/components/my_drawer.dart';
import 'package:gather/components/my_post_text_field.dart';
import 'package:gather/helper/helper_methods.dart';
import 'package:gather/pages/profile_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get the current user
  final currentUser=FirebaseAuth.instance.currentUser!;

  //text controller
  final TextEditingController _controller=TextEditingController();

  //display a dialog message
  void displayMessage(String message) {
    showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Icon(Icons.warning_amber,color: Colors.red,),
      content: Text("${message}",textAlign: TextAlign.center,style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),),
    ));
  }

  //sign user out
  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${e.toString()}")),
      );
    }
  }

  //post message
  void postMessage() async{
    try{
      //only post if there is something in the textfield
      if(_controller.text.trim().isNotEmpty){
        //get the username
        final userDoc=await
        FirebaseFirestore
            .instance
            .collection("Users")
            .doc(currentUser.email)
            .get();
        final userName=userDoc["username"] ?? currentUser.email;
        //store in firebase
        FirebaseFirestore.instance.collection("User Posts").add({
          "UserEmail":currentUser.email,
          "Username":userName,
          "Message":_controller.text.trim(),
          "TimeStamp":Timestamp.now(),
          "Likes":[],
        });
      }
    }
    //catch any errors
    on FirebaseAuthException catch(e){
      displayMessage(e.toString());
    }
    //clear the textfield
    setState(() {
      _controller.clear();
    });
  }

  //navigate to profile page
  void goToProfilePage() {
    //pop menu drawer
    Navigator.pop(context);
    //got to profile page
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //drawer icon theme
        iconTheme: IconThemeData(color: Colors.white),
        // Gather text
        title: Text("Gather",style: GoogleFonts.aBeeZee(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOutTap: signOut,
      ),
      body: Center(
        child: Column(
          children: [
            //gather
            Expanded(
                child:StreamBuilder(
                    stream: FirebaseFirestore
                        .instance
                        .collection("User Posts")
                        .orderBy("TimeStamp",descending: true)
                        .snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                            key: PageStorageKey("posts_list"),
                            itemBuilder: (context,index){
                              //get the message
                              final post=snapshot.data!.docs[index];
                              return GatherPost(
                                key: ValueKey(post.id),
                                message: post["Message"],
                                user: (post.data() as Map<String,dynamic>).containsKey("Username")
                                    ? post["Username"]
                                    : post["UserEmail"],
                                userEmail: post["UserEmail"],
                                postId: post.id,
                                likes: List<String>.from(post["Likes"] ?? []),
                                time: formatDate(post["TimeStamp"],),
                              );
                            }
                        );
                      } else if(snapshot.hasError){
                        return Center(
                          child: Text("Error : ${snapshot.error}"),
                        );
                      }
                      return const SizedBox.shrink();}
                ),
            ),
            //post messages
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: MediaQuery.of(context).padding.bottom + 10),
              child: Row(
                children: [
                  //textfield
                  Expanded(
                      child: MyPostTextField(
                          controller: _controller,
                          obscureText: false,
                          hintText: "Write something on the Gather",
                      )
                  ),
                  //post button
                  IconButton(
                      onPressed: postMessage,
                      icon: SvgPicture.asset("lib/assets/sendMessage.svg",width: 25,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
