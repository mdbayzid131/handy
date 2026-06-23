import 'package:handy/data/models/sermon_response_model.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? accessToken;
  final String? refreshToken;
  final List<SermonModel>? favoriteSermons;
  final String? initials;
  final String? memberSince;
  final String? status;
  final NotificationPreferences? notificationPreferences;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.avatar,
    this.accessToken,
    this.refreshToken,
    this.favoriteSermons,
    this.initials,
    this.memberSince,
    this.status,
    this.notificationPreferences,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['image'] ?? json['avatar'],
      accessToken: json['accessToken'] ?? json['token'],
      refreshToken: json['refreshToken'],
      favoriteSermons: json['favoriteSermons'] != null
          ? (json['favoriteSermons'] as List)
                .map((x) => SermonModel.fromJson(x))
                .toList()
          : null,
      initials: json['initials'],
      memberSince: json['member_since'],
      status: json['status'],
      notificationPreferences: json['notificationPreferences'] != null 
          ? NotificationPreferences.fromJson(json['notificationPreferences']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'favoriteSermons': favoriteSermons?.map((x) => x.toJson()).toList(),
      'initials': initials,
      'member_since': memberSince,
      'status': status,
      'notificationPreferences': notificationPreferences?.toJson(),
    };
  }
}

class NotificationPreferences {
  final bool sermon;
  final bool devotional;
  final bool event;
  final bool prayer;
  final bool serviceReminder;
  final bool custom;

  NotificationPreferences({
    this.sermon = true,
    this.devotional = true,
    this.event = true,
    this.prayer = true,
    this.serviceReminder = true,
    this.custom = true,
  });

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      sermon: json['sermon'] ?? true,
      devotional: json['devotional'] ?? true,
      event: json['event'] ?? true,
      prayer: json['prayer'] ?? true,
      serviceReminder: json['service_reminder'] ?? true,
      custom: json['custom'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sermon': sermon,
      'devotional': devotional,
      'event': event,
      'prayer': prayer,
      'service_reminder': serviceReminder,
      'custom': custom,
    };
  }
}

class GivingSummaryModel {
  final num? totalGivenThisYear;
  final String? currency;
  final int? year;
  final String? lastGift;
  final int? givingStreakWeeks;
  final num? totalGivenAllTime;
  final num? totalDonationsCount;

  GivingSummaryModel({
    this.totalGivenThisYear,
    this.currency,
    this.year,
    this.lastGift,
    this.givingStreakWeeks,
    this.totalGivenAllTime,
    this.totalDonationsCount,
  });

  factory GivingSummaryModel.fromJson(Map<String, dynamic> json) {
    String? parsedLastGift;
    if (json['last_gift'] != null) {
      if (json['last_gift'] is Map) {
        final map = json['last_gift'] as Map;
        final amount = map['amount']?.toString() ?? '';
        final date = map['date']?.toString() ?? '';
        if (amount.isNotEmpty) {
          final currency = json['currency'] ?? '£';
          parsedLastGift = '$currency$amount on $date';
        } else {
          parsedLastGift = map.toString();
        }
      } else {
        parsedLastGift = json['last_gift'].toString();
      }
    }

    return GivingSummaryModel(
      totalGivenThisYear: json['total_given_this_year'],
      currency: json['currency']?.toString(),
      year: json['year'],
      lastGift: parsedLastGift,
      givingStreakWeeks: json['giving_streak_weeks'],
      totalGivenAllTime: json['total_given_all_time'],
      totalDonationsCount: json['total_donations_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_given_this_year': totalGivenThisYear,
      'currency': currency,
      'year': year,
      'last_gift': lastGift,
      'giving_streak_weeks': givingStreakWeeks,
      'total_given_all_time': totalGivenAllTime,
      'total_donations_count': totalDonationsCount,
    };
  }
}
