import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Notification"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child:  Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.notifications_none,color: Colors.grey,),
                      SizedBox(width: 4,),
                      Text("New offer 😍",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),),

                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur. Tristique et mauris sem congue in felis id nec. Amet sed morbi bibendum vestibulum.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ) ,
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.notifications_none,color: Colors.grey,),
                      SizedBox(width: 4,),
                      Text("New offer 😍",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),),

                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur. Tristique et mauris sem congue in felis id nec. Amet sed morbi bibendum vestibulum.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ) ,
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.notifications_none,color: Colors.grey,),
                      SizedBox(width: 4,),
                      Text("Remember ⏰",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),),

                    ],
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Lorem ipsum dolor sit amet consectetur. Tristique et mauris sem congue in felis id nec. Amet sed morbi bibendum vestibulum.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ) ,

          ],
        ),
      ),
    );
  }
}
