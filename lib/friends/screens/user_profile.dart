import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/friends/models/book.dart';
import 'package:tenfoldlit_mobile/friends/models/user.dart';
import 'package:tenfoldlit_mobile/friends/models/userProfile.dart';
import 'package:tenfoldlit_mobile/friends/screens/book_detail.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  UserProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<Book>> fetchFavoriteBooks(int userId) async {
    final request = context.watch<CookieRequest>();
    var url = 'http://10.0.2.2:8000/get_favorite_books_user/$userId/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    List<Book> listBooks = [];
    for (var temp in response) {
      var book = Book.fromJson(temp);
      listBooks.add(book);
    }
    return listBooks;
  }

  Future<Profile> fetchUserProfile(int userId) async {
    final request = context.watch<CookieRequest>();
    var url = 'http://10.0.2.2:8000/get_user_profile/$userId/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    var profile = Profile.fromJson(response[0]);
    return profile;
  }

  Future<List<Book>> fetchBorrowedBooks(int userId) async {
    final request = context.watch<CookieRequest>();
    var url = 'http://10.0.2.2:8000/get_borrowed_books_user/$userId/';
    var response = await request.get(url);

    // melakukan konversi data json menjadi object Item
    List<Book> listBooks = [];
    for (var temp in response) {
      var book = Book.fromJson(temp);
      listBooks.add(book);
    }
    return listBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 149, 116, 81),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 240, 204),
        child: ListView(
          children: [
            Center(
              child: FutureBuilder(
                future: fetchUserProfile(widget.user.userId),
                builder: (context, AsyncSnapshot profileSnapshot) {
                  if (!profileSnapshot.hasData) {
                    return const SizedBox.shrink(); 
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: profileSnapshot.hasData && profileSnapshot.data.profile != null
                                ? Image.network(profileSnapshot.data.profile!)
                                : const Icon(Icons.account_circle_outlined, size: 120,),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(widget.user.username, style: const TextStyle(fontSize: 16),),
                          Text(widget.user.email, style: const TextStyle(fontSize: 16),),
                          const SizedBox(height: 30,),
                          Container(
                            child: TabBar(
                              controller: _tabController,
                              labelColor: Colors.black,
                              indicator: const BoxDecoration(color: Color.fromARGB(255, 216, 203, 174),),
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: const [
                                Tab(text: "Favorite Books",),
                                Tab(text: "Borrowed Books",)
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            child: SizedBox(
                              height: 400,
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  FutureBuilder(
                                    future: fetchFavoriteBooks(widget.user.userId), 
                                    builder: (context, AsyncSnapshot<List<Book>> favoriteSnapshot) {
                                      if (!favoriteSnapshot.hasData || favoriteSnapshot.data!.isEmpty) {
                                        return Container(
                                          child: const Center(
                                            child: Text(
                                              "Your friends does not have any favorite books yet."
                                            )
                                          )
                                        );
                                      } else {
                                        return GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 220,
                                            childAspectRatio: 0.55,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 10,
                                          ), 
                                          itemCount: favoriteSnapshot.data!.length,
                                          itemBuilder: (_, index) {
                                            Book currentBook = favoriteSnapshot.data![index];
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              margin: const EdgeInsets.symmetric(vertical: 10),
                                              alignment: Alignment.center,
                        
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: Colors.black
                                                )
                                              ),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 20,),
                                                    Container(
                                                      width: 130, 
                                                      height: 130,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Image.network(
                                                          currentBook.bookImage, 
                                                          fit: BoxFit.cover, 
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20,),
                                                    SizedBox(
                                                      height: 40,
                                                      child: Tooltip(
                                                        message: currentBook.title,
                                                        child: Text(
                                                          currentBook.title, 
                                                          textAlign: TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15,),
                                                    MaterialButton(
                                                      onPressed: (){
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => BookPage(book : currentBook)),
                                                        );
                                                      },
                                                      minWidth: 150,
                                                      shape: RoundedRectangleBorder(                                    
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      color: Colors.black,
                                                      child: const Text('See Detail', style: TextStyle(color: Colors.white),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                      }
                                    }
                                  ),
                                  FutureBuilder(
                                    future: fetchBorrowedBooks(widget.user.userId), 
                                    builder: (context, AsyncSnapshot<List<Book>> borrowedSnapshot) {
                                      if (!borrowedSnapshot.hasData  || borrowedSnapshot.data!.isEmpty) {
                                        return Container(
                                          child: const Center(
                                            child: Text(
                                              "Your friends has not borrowed any books yet."
                                            )
                                          )
                                        );
                                      } else {
                                        return GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 220,
                                            childAspectRatio: 0.55,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 10,
                                          ), 
                                          itemCount: borrowedSnapshot.data!.length,
                                          itemBuilder: (_, index) {
                                            Book currentBook = borrowedSnapshot.data![index];
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                              margin: const EdgeInsets.symmetric(vertical: 10),
                                              alignment: Alignment.center,
                        
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: Colors.black
                                                )
                                              ),
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 20,),
                                                    Container(
                                                      width: 130, 
                                                      height: 130,
                                                      child: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: Image.network(
                                                          currentBook.bookImage, 
                                                          fit: BoxFit.cover, 
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20,),
                                                    SizedBox(
                                                      height: 40,
                                                      child: Tooltip(
                                                        message: currentBook.title,
                                                        child: Text(
                                                          currentBook.title, 
                                                          textAlign: TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15,),
                                                    MaterialButton(
                                                      onPressed: (){
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => BookPage(book : currentBook)),
                                                        );
                                                      },
                                                      minWidth: 150,
                                                      shape: RoundedRectangleBorder(                                    
                                                        borderRadius: BorderRadius.circular(10)
                                                      ),
                                                      color: Colors.black,
                                                      child: const Text('See Detail', style: TextStyle(color: Colors.white),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        );
                                      }
                                    }
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}
