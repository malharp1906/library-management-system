import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';

class AddBookScreen extends StatefulWidget {
  final VoidCallback onBookAdded;

  const AddBookScreen({super.key, required this.onBookAdded});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _isbnController = TextEditingController();
  bool _isLoading = false;

  void _submitData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final newBook = Book(
        title: _titleController.text.trim(),
        author: _authorController.text.trim(),
        isbn: _isbnController.text.trim(),
      );

      try {
        await ApiService.createBook(newBook);
        if (!mounted) return;
        setState(() => _isLoading = false);
        widget.onBookAdded();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Book added successfully!')),
        );

        _titleController.clear();
        _authorController.clear();
        _isbnController.clear();
      } catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving book: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF253B9B);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        title: const Text(
          'ADD BOOK',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black87),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: primaryColor,
              radius: 16,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'ENTRY DETAILS',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Step 1 of 1',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey.shade400,
                ),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Expand your digital library with a few taps.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField(
                'BOOK TITLE',
                'e.g. The Great Gatsby',
                _titleController,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                'AUTHOR',
                'e.g. F. Scott Fitzgerald',
                _authorController,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                'ISBN',
                '978-3-16-148410-0',
                _isbnController,
                suffixIcon: Icons.qr_code_scanner,
              ),
              const Text(
                'Scan the barcode to auto-fill details.',
                style: TextStyle(color: Colors.grey, fontSize: 11),
              ),
              const SizedBox(height: 20),
              const Text(
                'CATEGORY (OPTIONAL)',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: const Text('Fiction'),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Chip(
                    label: const Text('History'),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Chip(
                    label: const Text('Science'),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  Chip(
                    label: const Text('+ Add'),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _submitData,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Save Book',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint,
    TextEditingController controller, {
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: (value) =>
              (value == null || value.isEmpty) ? 'Field cannot be empty' : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: const Color(0xFF253B9B))
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }
}
