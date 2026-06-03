import 'package:get/get.dart';
import '../../../data/models/bible_model.dart';

class BibleController extends GetxController {
  final isOldTestament = false.obs;
  final searchQuery = ''.obs;

  void toggleTestament(bool isOld) {
    isOldTestament.value = isOld;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  List<BibleBook> get filteredBooks {
    final books = allBooks.where((book) => book.isOldTestament == isOldTestament.value).toList();
    if (searchQuery.value.isEmpty) {
      return books;
    }
    return books.where((book) => book.name.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
  }

  final List<BibleBook> allBooks = [
    // Old Testament
    BibleBook(name: 'Genesis', chaptersCount: 50, isOldTestament: true),
    BibleBook(name: 'Exodus', chaptersCount: 40, isOldTestament: true),
    BibleBook(name: 'Leviticus', chaptersCount: 27, isOldTestament: true),
    BibleBook(name: 'Numbers', chaptersCount: 36, isOldTestament: true),
    BibleBook(name: 'Deuteronomy', chaptersCount: 34, isOldTestament: true),
    BibleBook(name: 'Joshua', chaptersCount: 24, isOldTestament: true),
    BibleBook(name: 'Judges', chaptersCount: 21, isOldTestament: true),
    BibleBook(name: 'Ruth', chaptersCount: 4, isOldTestament: true),
    BibleBook(name: '1 Samuel', chaptersCount: 31, isOldTestament: true),
    BibleBook(name: '2 Samuel', chaptersCount: 24, isOldTestament: true),
    BibleBook(name: '1 Kings', chaptersCount: 22, isOldTestament: true),
    BibleBook(name: '2 Kings', chaptersCount: 25, isOldTestament: true),
    BibleBook(name: '1 Chronicles', chaptersCount: 29, isOldTestament: true),
    BibleBook(name: '2 Chronicles', chaptersCount: 36, isOldTestament: true),
    BibleBook(name: 'Ezra', chaptersCount: 10, isOldTestament: true),
    BibleBook(name: 'Nehemiah', chaptersCount: 13, isOldTestament: true),
    BibleBook(name: 'Esther', chaptersCount: 10, isOldTestament: true),
    BibleBook(name: 'Job', chaptersCount: 42, isOldTestament: true),
    BibleBook(name: 'Psalms', chaptersCount: 150, isOldTestament: true),
    BibleBook(name: 'Proverbs', chaptersCount: 31, isOldTestament: true),
    BibleBook(name: 'Ecclesiastes', chaptersCount: 12, isOldTestament: true),
    BibleBook(name: 'Song of Solomon', chaptersCount: 8, isOldTestament: true),
    BibleBook(name: 'Isaiah', chaptersCount: 66, isOldTestament: true),
    BibleBook(name: 'Jeremiah', chaptersCount: 52, isOldTestament: true),
    BibleBook(name: 'Lamentations', chaptersCount: 5, isOldTestament: true),
    BibleBook(name: 'Ezekiel', chaptersCount: 48, isOldTestament: true),
    BibleBook(name: 'Daniel', chaptersCount: 12, isOldTestament: true),
    BibleBook(name: 'Hosea', chaptersCount: 14, isOldTestament: true),
    BibleBook(name: 'Joel', chaptersCount: 3, isOldTestament: true),
    BibleBook(name: 'Amos', chaptersCount: 9, isOldTestament: true),
    BibleBook(name: 'Obadiah', chaptersCount: 1, isOldTestament: true),
    BibleBook(name: 'Jonah', chaptersCount: 4, isOldTestament: true),
    BibleBook(name: 'Micah', chaptersCount: 7, isOldTestament: true),
    BibleBook(name: 'Nahum', chaptersCount: 3, isOldTestament: true),
    BibleBook(name: 'Habakkuk', chaptersCount: 3, isOldTestament: true),
    BibleBook(name: 'Zephaniah', chaptersCount: 3, isOldTestament: true),
    BibleBook(name: 'Haggai', chaptersCount: 2, isOldTestament: true),
    BibleBook(name: 'Zechariah', chaptersCount: 14, isOldTestament: true),
    BibleBook(name: 'Malachi', chaptersCount: 4, isOldTestament: true),

    // New Testament
    BibleBook(name: 'Matthew', chaptersCount: 28, isOldTestament: false),
    BibleBook(name: 'Mark', chaptersCount: 16, isOldTestament: false),
    BibleBook(name: 'Luke', chaptersCount: 24, isOldTestament: false),
    BibleBook(name: 'John', chaptersCount: 21, isOldTestament: false),
    BibleBook(name: 'Acts', chaptersCount: 28, isOldTestament: false),
    BibleBook(name: 'Romans', chaptersCount: 16, isOldTestament: false),
    BibleBook(name: '1 Corinthians', chaptersCount: 16, isOldTestament: false),
    BibleBook(name: '2 Corinthians', chaptersCount: 13, isOldTestament: false),
    BibleBook(name: 'Galatians', chaptersCount: 6, isOldTestament: false),
    BibleBook(name: 'Ephesians', chaptersCount: 6, isOldTestament: false),
    BibleBook(name: 'Philippians', chaptersCount: 4, isOldTestament: false),
    BibleBook(name: 'Colossians', chaptersCount: 4, isOldTestament: false),
    BibleBook(name: '1 Thessalonians', chaptersCount: 5, isOldTestament: false),
    BibleBook(name: '2 Thessalonians', chaptersCount: 3, isOldTestament: false),
    BibleBook(name: '1 Timothy', chaptersCount: 6, isOldTestament: false),
    BibleBook(name: '2 Timothy', chaptersCount: 4, isOldTestament: false),
    BibleBook(name: 'Titus', chaptersCount: 3, isOldTestament: false),
    BibleBook(name: 'Philemon', chaptersCount: 1, isOldTestament: false),
    BibleBook(name: 'Hebrews', chaptersCount: 13, isOldTestament: false),
    BibleBook(name: 'James', chaptersCount: 5, isOldTestament: false),
    BibleBook(name: '1 Peter', chaptersCount: 5, isOldTestament: false),
    BibleBook(name: '2 Peter', chaptersCount: 3, isOldTestament: false),
    BibleBook(name: '1 John', chaptersCount: 5, isOldTestament: false),
    BibleBook(name: '2 John', chaptersCount: 1, isOldTestament: false),
    BibleBook(name: '3 John', chaptersCount: 1, isOldTestament: false),
    BibleBook(name: 'Jude', chaptersCount: 1, isOldTestament: false),
    BibleBook(name: 'Revelation', chaptersCount: 22, isOldTestament: false),
  ];
}
