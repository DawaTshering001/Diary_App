import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/diary_entry.dart';

class EntryDialog extends StatefulWidget {
  final Function(DiaryEntry) onAdd;

  const EntryDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  _EntryDialogState createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  List<String> _imagePaths = []; // List to store multiple image paths
  String _content = ''; // Store the content text

  void _submit() {
    if (_titleController.text.isEmpty || _content.isEmpty) {
      // Show validation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    final newEntry = DiaryEntry(
      title: _titleController.text,
      content: _content,
      date: _selectedDate.toIso8601String(),
    );
    widget.onAdd(newEntry);
    Navigator.of(context).pop();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePaths.add(image.path); // Add the selected image path to the list
        _content += '\n[IMAGE:${_imagePaths.length - 1}]'; // Append placeholder text for the image
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Diary'),
        backgroundColor: Colors.purple,
        actions: [
          TextButton(
            onPressed: _submit,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: const TextStyle(color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Date: ${_selectedDate.toLocal()}'.split(' ')[0],
                      labelStyle: const TextStyle(color: Colors.teal),
                      suffixIcon: Icon(Icons.calendar_today, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.teal),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: const TextStyle(color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.teal),
                  ),
                ),
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                onChanged: (text) {
                  _content = text; // Update content with the text field input
                },
              ),
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.add_a_photo, color: Colors.teal),
                label: const Text('Add Image', style: TextStyle(color: Colors.teal)),
              ),
              const SizedBox(height: 20),
              // Display the selected images below the content
              if (_imagePaths.isNotEmpty) ...[
                const Text('Images:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _imagePaths.map((path) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.file(
                        File(path),
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

void showFullScreenEntryDialog(BuildContext context, Function(DiaryEntry) onAdd) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: EntryDialog(onAdd: onAdd),
    ),
  );
}
