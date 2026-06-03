import 'package:get/get.dart';

class BibleVersesController extends GetxController {
  final bookName = ''.obs;
  final chapter = 1.obs;
  final maxChapters = 50.obs; // Hardcoded dummy for next/prev logic limit

  final verses = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      bookName.value = args['book'] ?? 'Genesis';
      chapter.value = args['chapter'] ?? 1;
    }
    _loadDummyVerses();
  }

  void _loadDummyVerses() {
    verses.clear();
    // Generating dummy verses based on user's screenshot
    final dummyTexts = [
      "There was a man of the Pharisees named Nicodemus, a ruler of the Jews.",
      "This man came to Jesus by night and said to him, Rabbi, we know that you are a teacher come from God, for no one can do these signs that you do unless God is with him.",
      "Jesus answered him, Truly, truly, I say to you, unless one is born again he cannot see the kingdom of God.",
      "Nicodemus said to him, How can a man be born when he is old? Can he enter a second time into his mother's womb and be born?",
      "Jesus answered, Truly, truly, I say to you, unless one is born of water and the Spirit, he cannot enter the kingdom of God.",
      "That which is born of the flesh is flesh, and that which is born of the Spirit is spirit.",
      "Do not marvel that I said to you, 'You must be born again.'",
      "The wind blows where it wishes, and you hear its sound, but you do not know where it comes from or where it goes. So it is with everyone who is born of the Spirit.",
      "Nicodemus said to him, How can these things be?",
      "Jesus answered him, Are you the teacher of Israel and yet you do not understand these things?",
      "Truly, truly, I say to you, we speak of what we know, and bear witness to what we have seen, but you do not receive our testimony.",
      "If I have told you earthly things and you do not believe, how can you believe if I tell you heavenly things?",
      "No one has ascended into heaven except he who descended from heaven, the Son of Man.",
      "And as Moses lifted up the serpent in the wilderness, so must the Son of Man be lifted up,",
      "that whoever believes in him may have eternal life.",
      "For God so loved the world, that he gave his only Son, that whoever believes in him should not perish but have eternal life.",
      "For God did not send his Son into the world to condemn the world, but in order that the world might be saved through him.",
      "Whoever believes in him is not condemned, but whoever does not believe is condemned already, because he has not believed in the name of the only Son of God.",
      "And this is the judgment: the light has come into the world, and people loved the darkness rather than the light because their works were evil.",
      "For everyone who does wicked things hates the light and does not come to the light, lest his works should be exposed.",
      "But whoever does what is true comes to the light, so that it may be clearly seen that his works have been carried out in God."
    ];
    
    verses.addAll(dummyTexts);
  }

  void nextChapter() {
    if (chapter.value < maxChapters.value) {
      chapter.value++;
      _loadDummyVerses();
    }
  }

  void previousChapter() {
    if (chapter.value > 1) {
      chapter.value--;
      _loadDummyVerses();
    }
  }
}
