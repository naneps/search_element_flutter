import 'package:flutter/material.dart';

import 'model/book.dart';

class MainPageState extends StatefulWidget {
  const MainPageState({Key? key}) : super(key: key);

  @override
  State<MainPageState> createState() => _MainPageStateState();
}

class _MainPageStateState extends State<MainPageState> {
  final controller = TextEditingController();
  List<Book>? books = allBooks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              onChanged: searchBok,
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.purple, width: 1)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books!.length,
              itemBuilder: (context, index) {
                final book = books![index];
                return ListTile(
                  leading: Image.network(
                    book.urlImage!,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(book.title!),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookPage(
                          book: book,
                        ),
                      )),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void searchBok(String query) {
    final sugestions = allBooks.where((book) {
      final bookTitle = book.title!.toLowerCase();
      final input = query.toLowerCase();
      return bookTitle.contains(input);
    }).toList();
    setState(() {
      books = sugestions;
    });
  }
}

class BookPage extends StatelessWidget {
  final Book? book;
  const BookPage({this.book, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book!.title!),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            // height: 100,
            // color: Colors.green,
            child: Image.network(book!.urlImage.toString()),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              '${book!.title}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
