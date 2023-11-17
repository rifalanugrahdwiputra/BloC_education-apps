import 'package:flutter/material.dart';

class AnnouncementWidget {
  Widget announcementInfo(dynamic announcementData) {
    if (announcementData != null &&
        announcementData['data'] != null &&
        announcementData['data']['results'] != null) {
      var results = announcementData['data']['results'];
      return Column(
        children: [
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: results.length,
              itemBuilder: (BuildContext context, int index) {
                var announcement = results[index];
                return SizedBox(
                  width: 250,
                  child: Card(
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      child: Image.network(
                        announcement['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return const Text('Data pengumuman tidak tersedia');
    }
  }
}
