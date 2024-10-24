import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final writerController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    writerController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('작성자'),
          TextField(controller: writerController),
          Text('제목'),
          TextField(controller: titleController),
          Text('내용'),
          TextField(controller: contentController),
          ElevatedButton(
            onPressed: () async {
              // TODO empty 체크
              // Loader
              // Goback
              // ViewModel
              final docRef =
                  FirebaseFirestore.instance.collection('post').doc();
              docRef.set({
                'id': docRef.id,
                'writer': writerController.text,
                'title': titleController.text,
                'content': contentController.text,
                'createdAt': DateTime.now().toIso8601String(),
              });
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}
