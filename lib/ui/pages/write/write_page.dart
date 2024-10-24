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

  final formKey = GlobalKey<FormState>();

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
        appBar: AppBar(
          title: Text('글쓰기'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('글쓰기'),
          actions: [
            GestureDetector(
              onTap: () async {
                if (state.imageUrl == null) {
                  return;
                }
                if (!formKey.currentState!.validate()) {
                  return;
                }
                final result = await vm.insert(
                  writer: writerController.text,
                  title: titleController.text,
                  content: contentController.text,
                );
                if (result && mounted) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  '완료',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8)
          ],
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                label('작성자'),
                TextFormField(
                  controller: writerController,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return '작성자를 입력해 주세요';
                    }
                    return null;
                  },
                ),
                label('제목'),
                TextFormField(
                  controller: titleController,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return '제목을 입력해 주세요';
                    }
                    return null;
                  },
                ),
                label('내용'),
                SizedBox(
                  height: 200,
                  child: TextFormField(
                    controller: contentController,
                    maxLines: null,
                    expands: true,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return '내용을 입력해 주세요';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      vm.pickImage();
                    },
                    child: state.imageUrl == null
                        ? Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey,
                            child: Icon(Icons.image),
                          )
                        : SizedBox(
                            height: 100,
                            child: Image.network(state.imageUrl!),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
