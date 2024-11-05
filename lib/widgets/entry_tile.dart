import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import '../screens/entry_detail_screen.dart';

class EntryTile extends StatelessWidget {
  final DiaryEntry entry;
  final Function onDelete;

  const EntryTile({Key? key, required this.entry, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          child: Text(
            entry.title.isNotEmpty ? entry.title[0] : '?',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          entry.title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            entry.content.length > 50 ? '${entry.content.substring(0, 50)}...' : entry.content,
            style: const TextStyle(fontSize: 14.0, color: Colors.black54),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => onDelete(),
        ),
        onTap: () {
          // Navigate to full-screen detail page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EntryDetailScreen(entry: entry),
            ),
          );
        },
      ),
    );
  }
}
