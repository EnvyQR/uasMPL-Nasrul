import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InstagramHome(),
    );
  }
}

class InstagramHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildStories(context),
          _buildFeed(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildStories(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildStory(context, 'Your Story', 'assets/your_story.jpeg', isYourStory: true),
          _buildStory(context, 'Envy', 'assets/friend1.jpeg'),
          _buildStory(context, 'Satoru', 'assets/friend2.jpeg'),
          _buildStory(context, 'Suguru', 'assets/friend3.jpeg'),
          // Add more stories here
        ],
      ),
    );
  }

  Widget _buildStory(BuildContext context, String name, String imagePath, {bool isYourStory = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StoryPage(name: name, imagePath: imagePath),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isYourStory ? Colors.red : Colors.grey, width: 3),
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          SizedBox(height: 5),
          Text(name, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFeed() {
    return Column(
      children: [
        FeedPost(username: 'Envy', userImage: 'assets/friend1.jpeg', postImage: 'assets/post1.jpeg', caption: 'This is a beautiful place!'),
        FeedPost(username: 'Satoru', userImage: 'assets/friend2.jpeg', postImage: 'assets/post2.jpeg', caption: 'Love this view!'),
        // Add more posts here
      ],
    );
  }
}

class FeedPost extends StatefulWidget {
  final String username;
  final String userImage;
  final String postImage;
  final String caption;

  FeedPost({required this.username, required this.userImage, required this.postImage, required this.caption});

  @override
  _FeedPostState createState() => _FeedPostState();
}

class _FeedPostState extends State<FeedPost> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(widget.userImage),
          ),
          title: Text(widget.username),
          trailing: Icon(Icons.more_vert),
        ),
        Image.asset(widget.postImage),
        Row(
          children: [
            IconButton(
              icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border),
              color: isLiked ? Colors.red : Colors.black,
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.comment_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.bookmark_border),
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(widget.username + ' ' + widget.caption),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

class StoryPage extends StatelessWidget {
  final String name;
  final String imagePath;

  StoryPage({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
