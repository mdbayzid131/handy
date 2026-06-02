import 'package:get/get.dart';
import '../../../data/models/sermons_model.dart';

class SermonsController extends GetxController {
  final searchQuery = ''.obs;
  final selectedCategory = 'All'.obs;

  final categories = [
    'All',
    'Walking in Faith',
    'The Beatitudes',
    'Acts of the Apostles',
    'Psalms of Praise',
    'Advent'
  ];

  final allSermons = <Sermon>[
    Sermon(id: '1', category: 'WALKING IN FAITH', title: 'The Anchor of Hope', pastor: 'Pastor Emmanuel Asante', date: 'May 4, 2025', duration: '42 min'),
    Sermon(id: '2', category: 'THE BEATITUDES', title: 'Blessed Are the Poor in Spirit', pastor: 'Pastor Emmanuel Asante', date: 'Apr 27, 2025', duration: '38 min'),
    Sermon(id: '3', category: 'ACTS OF THE APOSTLES', title: 'The Holy Spirit Comes', pastor: 'Elder Grace Mensah', date: 'Apr 20, 2025', duration: '45 min'),
    Sermon(id: '4', category: 'PSALMS OF PRAISE', title: 'Sing a New Song', pastor: 'Deacon David Boateng', date: 'Apr 13, 2025', duration: '35 min'),
    Sermon(id: '5', category: 'PSALMS OF PRAISE', title: 'Mourning into Dancing', pastor: 'Pastor Emmanuel Asante', date: 'Apr 6, 2025', duration: '40 min'),
    Sermon(id: '6', category: 'THE BEATITUDES', title: 'Blessed Are the Meek', pastor: 'Elder Grace Mensah', date: 'Mar 30, 2025', duration: '37 min'),
    Sermon(id: '7', category: 'WALKING IN FAITH', title: 'Walking by Faith, Not by Sight', pastor: 'Pastor Emmanuel Asante', date: 'Mar 23, 2025', duration: '44 min'),
    Sermon(id: '8', category: 'ADVENT', title: 'Come, Emmanuel', pastor: 'Pastor Emmanuel Asante', date: 'Dec 22, 2024', duration: '50 min'),
  ].obs;

  List<Sermon> get filteredSermons {
    return allSermons.where((sermon) {
      final matchesSearch = sermon.title.toLowerCase().contains(searchQuery.value.toLowerCase()) || 
                            sermon.pastor.toLowerCase().contains(searchQuery.value.toLowerCase());
      final matchesCategory = selectedCategory.value == 'All' || 
                              sermon.category.toLowerCase() == selectedCategory.value.toLowerCase();
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}