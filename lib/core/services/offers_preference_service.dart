// import 'dart:convert';
// import 'package:nicestore/features/offers/domain/model/offers_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class OffersPreferencesService {
// static const String  _offersKey = 'offers_data';



//   // Get Offers data from SharedPreferences
//   static Future<Offers?> getOffersData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final offersJson = prefs.getString(_offersKey);

//     if (offersJson != null) {
//       try {
//         final offersMap = jsonDecode(offersJson) as Map<String, dynamic>;
//         return Offers.fromJson(offersMap);
//       } catch (e) {
//         // If parsing fails, clear the corrupted data
//         await clearOffersData();
//         return null;
//       }
//     }
//     return null;
//   }



//   // Clear all Offers data (logout)
//   static Future<void> clearOffersData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_offersKey);

//   }

 
// }
