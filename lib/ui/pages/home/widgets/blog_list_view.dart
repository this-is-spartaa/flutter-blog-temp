import 'package:flutter/material.dart';

class BlogListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = ['나의 개발 일지', '겨울 추위를 피해서', '테스트 입니다'];
    final images = [
      'https://i.pinimg.com/736x/4e/0d/ef/4e0def0f8238b276c4cadb8bb7b87068.jpg',
      'https://img.freepik.com/free-photo/view-breathtaking-beach-nature-landscape_23-2151682888.jpg',
      'https://i.pinimg.com/736x/55/03/c1/5503c12391704393361d5b39138c1c61.jpg',
    ];
    return ListView.separated(
      itemCount: 3,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        return item(
          title[index],
          title[index] * 10,
          '2024년 09월 09일',
          images[index],
        );
      },
    );
  }

  Container item(
    String title,
    String content,
    String date,
    String imageUrl,
  ) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(20),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(right: 100),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Spacer(),
                Text(
                  content,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
