import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String icon;
  final String label;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
    //  context.pushOutstationBooking();
      //        Navigator.of(context).push(
      // MaterialPageRoute(builder: (context) => OutstationBookingScreen()));
      },
      child: Container(
        width: 120,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              
            
              child: Image.asset(height: 40,width: 90,icon,fit: BoxFit.cover,),
            ),
           
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
