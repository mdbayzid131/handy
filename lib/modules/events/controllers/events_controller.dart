import 'package:get/get.dart';
import '../../../data/models/events_model.dart';

class EventsController extends GetxController {
  final selectedCategory = 'All'.obs;

  final List<String> categories = ['All', 'Worship', 'Youth', 'Prayer', 'Study', 'Community'];

  final events = <EventModel>[
    EventModel(
      id: '1',
      category: 'Study',
      title: 'Women\'s Bible Study',
      date: 'May 8, 2025',
      time: '10:00 AM',
      location: 'Room 204',
      attendeeCount: 29,
      description: 'Join us as we dive deep into the Word of God, studying the book of Ruth. Coffee and snacks will be provided. All women are welcome!',
    ),
    EventModel(
      id: '2',
      category: 'Worship',
      title: 'Sunday Worship Service',
      date: 'May 11, 2025',
      time: '9:00 AM & 11:00 AM',
      location: 'Main Sanctuary',
      attendeeCount: 247,
      description: 'Our regular Sunday service featuring contemporary worship and a powerful message from Pastor John. Children\'s ministry is available during both services.',
    ),
    EventModel(
      id: '3',
      category: 'Worship',
      title: 'Baptism Sunday',
      date: 'May 18, 2025',
      time: '11:00 AM',
      location: 'Main Sanctuary',
      attendeeCount: 183,
      description: 'Celebrate with those taking the next step in their faith journey! If you would like to be baptized, please register online before Wednesday.',
    ),
    EventModel(
      id: '4',
      category: 'Youth',
      title: 'Youth Night: Ignite',
      date: 'May 9, 2025',
      time: '6:30 PM',
      location: 'Youth Hall',
      attendeeCount: 64,
      description: 'An evening of fun, games, worship, and an inspiring message specifically for teenagers (ages 13-18). Bring a friend!',
    ),
    EventModel(
      id: '5',
      category: 'Prayer',
      title: 'Wednesday Prayer Meeting',
      date: 'May 7, 2025',
      time: '7:00 PM',
      location: 'Prayer Room',
      attendeeCount: 52,
      description: 'Join us for corporate prayer as we intercede for our community, our nation, and specific needs within the congregation.',
    ),
    EventModel(
      id: '6',
      category: 'Community',
      title: 'Men\'s Breakfast Fellowship',
      date: 'May 10, 2025',
      time: '7:30 AM',
      location: 'Fellowship Hall',
      attendeeCount: 41,
      description: 'A great time of food, fellowship, and a short devotional. A perfect opportunity to connect with other men in the church.',
    ),
  ].obs;

  List<EventModel> get filteredEvents {
    if (selectedCategory.value == 'All') {
      return events;
    }
    return events.where((event) => event.category == selectedCategory.value).toList();
  }
}