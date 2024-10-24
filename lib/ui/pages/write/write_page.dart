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
  late final writerController =
      TextEditingController(text: widget.post?.writer);
  late final titleController = TextEditingController(text: widget.post?.title);
  late final contentController =
      TextEditingController(text: widget.post?.content);

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
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('작성자'),
            TextField(controller: writerController),
            Text('제목'),
            TextField(controller: titleController),
            Text('내용'),
            TextField(controller: contentController),
            Row(
              children: [
                Container(
                  height: 100,
                  child: state.imageUrl == null
                      ? null
                      : Image.network(state.imageUrl!),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    vm.pickImage();
                  },
                  child: Text('사진'),
                )
              ],
            ),
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
      ),
    );
  }
}
