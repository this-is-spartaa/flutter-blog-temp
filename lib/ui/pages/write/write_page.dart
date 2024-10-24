import 'package:flutter/material.dart';
import 'package:flutter_blog_app/data/model/post.dart';
import 'package:flutter_blog_app/ui/pages/write/write_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WritePage extends ConsumerStatefulWidget {
  const WritePage({super.key, required this.post});

  final Post? post;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WritePageState();
}

class _WritePageState extends ConsumerState<WritePage> {
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
    final state = ref.watch(writeViewModel(widget.post));
    final vm = ref.read(writeViewModel(widget.post).notifier);
    if (state.isWriting) {
      // TODO
      return CircularProgressIndicator();
    }
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('작성자'),
          TextField(controller: writerController),
          Text('제목'),
          TextField(controller: titleController),
          Text('내용'),
          TextField(controller: contentController),
          ElevatedButton(
            onPressed: () async {
              final result = await vm.insert(
                writer: writerController.text,
                title: titleController.text,
                content: contentController.text,
              );
              if (result && mounted) {
                Navigator.pop(context);
              }
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }
}
