import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gather/components/comment.dart';
import 'package:gather/components/comment_button.dart';
import 'package:gather/components/delete_button.dart';
import 'package:gather/components/like_button.dart';
import 'package:gather/helper/helper_methods.dart';

class GatherPost extends StatefulWidget {
  final String message;
  final String userEmail;
  final String user;
  final String postId;
  final String time;
  final List<String> likes;
  const GatherPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.time,
    required this.userEmail,
  });

  @override
  State<GatherPost> createState() => _GatherPostState();
}

class _GatherPostState extends State<GatherPost> {

  //get the user
  final currentUser=FirebaseAuth.instance.currentUser!;
  bool isLiked=false;

  // comment text controller
  final _commentTextController=TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked=widget.likes.contains(currentUser.email);
  }

  @override
  void didUpdateWidget(GatherPost oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.likes != widget.likes) {
      isLiked = widget.likes.contains(currentUser.email);
    }
  }

  // toggle like
  void toggleLike() {
    setState(() {
      isLiked=!isLiked;
    });
    //Access the document in Firebase
    DocumentReference postRef=FirebaseFirestore.instance.collection("User Posts").doc(widget.postId);
    if(isLiked){
      //if the post is now liked , add the user's email to the "Likes" field
      postRef.update({
        "Likes":FieldValue.arrayUnion([currentUser.email]),
      });
    }else {
      //if the post is now unliked , remover the user's email to the "Likes" field
      postRef.update({
        "Likes":FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  //add a comment
  void addComment(String commentText) async {
    //get the username
    final userDoc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.email)
        .get();
    final username = userDoc["username"] ?? currentUser.email;

    //write the comment to firestore under the comments collection for this post
    FirebaseFirestore.instance.collection("User Posts").doc(widget.postId).collection("Comments").add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentedByUsername": username,
      "CommentTime": Timestamp.now(),
    });
  }

  //show a dialog box for adding comment
  void showCommentDialog() {
    showDialog(context: context, builder: (context)=>AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text("Add a Comment"),
      content: TextField(
        style: TextStyle(color: Colors.black),
        controller: _commentTextController,
        decoration: InputDecoration(
          hintText: "Write a comment",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade600),
            )
        ),
      ),
      actions: [
        //cancel button
        TextButton(
          onPressed:(){
            //pop box
            Navigator.pop(context);
            //clear the controller
            _commentTextController.clear();
          },
          child: Text("Cancel",style: TextStyle(color: Colors.black),),
        ),
        //post button
        TextButton(
            onPressed: () {
              //pop the box
              Navigator.pop(context);
              //add a comment
              addComment(_commentTextController.text.trim());
              //clear the controller
              _commentTextController.clear();
          },
            child: Text("Post",style: TextStyle(color: Colors.black),)
        ),
      ],
    ));
  }

  //delete a post
  void deletePost() {
    //show a dialog box asking for confirmation before deleting the post
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Delete post"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: const Text("Are you sure you want to delete this post?"),
      actions: [
        //cancel button
        TextButton(onPressed: ()=>Navigator.pop(context), child: Text("Cancel",style: TextStyle(color: Colors.black),)),
        //delete button
        TextButton(onPressed: () async{
          //delete the comments from firestore
          final commentDocs=await FirebaseFirestore
              .instance
              .collection("User Posts")
              .doc(widget.postId)
              .collection("Comments")
              .get();
          for(var doc in commentDocs.docs) {
            await FirebaseFirestore
                .instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Comments")
                .doc(doc.id)
                .delete();
          }
          //then delete the post
          FirebaseFirestore
              .instance
              .collection("User Posts")
              .doc(widget.postId)
              .delete()
              .then((value)=>print("Post deleted"))
              .catchError((error)=>print("failed to delete"));
          //dismiss the dialog box
          Navigator.pop(context);
          }, child: Text("Delete",style: TextStyle(color: Colors.black),)),
      ],
    ));
  }


  @override
  Widget build(BuildContext context) {
    //device sized with media query
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 25, left: 25,right: 25),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //gather post
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //group of text (message+user email)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //message
                    Text(
                      widget.message,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height:screenHeight*0.01,),
                    //user
                    Row(
                      children: [
                        Flexible(child: Text("@${widget.user}",style: TextStyle(color: Colors.grey.shade600),)),
                        Text("  .  "),
                        Text(widget.time,style: TextStyle(color: Colors.grey.shade600),),
                      ],
                    ),
                  ],
                ),
              ),
              //delete button
              if(widget.userEmail==currentUser.email)
                DeleteButton(onTap: ()=>deletePost()),
            ],
          ),
          SizedBox(height: screenHeight*0.02,),
          //buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //LIKE
              Column(
                children: [
                  //like button
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(height: 5,),
                  //like count
                  Text(widget.likes.length.toString()),
                ],
              ),
              SizedBox(width: screenWidth*0.02,),
              //COMMENT
              Column(
                children: [
                  //comment button
                  CommentButton(onTap: showCommentDialog),
                  const SizedBox(height: 5,),
                  //comment count
                  //get the comment count
                  StreamBuilder(
                      stream: FirebaseFirestore
                          .instance
                          .collection("User Posts")
                          .doc(widget.postId)
                          .collection("Comments")
                          .snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return const Text("0");
                        }
                        int commentCount=snapshot.data!.docs.length;
                        return Text(commentCount.toString());
                      }
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10,),
          Text("Comments"),
          SizedBox(height: 10,),
          //comments under the posts
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore
                  .instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .orderBy("CommentTime",descending: true)
                  .snapshots(),
              builder: (context,snapshot){
                //show loading circle if no data yet
                if(!snapshot.hasData || snapshot.connectionState==ConnectionState.waiting){
                  return const SizedBox.shrink();
                }
                return ListView(
                  shrinkWrap: true, // for nested lists
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    //get the comment from firebase
                    final commentData=doc.data() as Map<String,dynamic>;
                    // return the comment
                    return Comment(
                        text: commentData["CommentText"],
                        user: commentData["CommentedByUsername"] ?? commentData["CommentedBy"],
                        time: formatDate(commentData["CommentTime"]),
                    );
                  }).toList(),
                );
              },
          ),
        ],
      ),
    );
  }
}
