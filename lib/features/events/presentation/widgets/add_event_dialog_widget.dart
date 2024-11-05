
import 'package:flutter/material.dart';
import 'package:tickoyakovendors/core/colors.dart';
import 'package:tickoyakovendors/core/commons/bg-widget.dart';

class AddEventDialog extends StatefulWidget {
  const AddEventDialog({super.key});

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _venueController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _priceController = TextEditingController();
  final _contactController = TextEditingController();
  final _eventOwnerController = TextEditingController();
  
  DateTime _selectedDate = DateTime.now();
  String _selectedType = 'Concert'; // Default value

  final List<String> _eventTypes = [
    'Concert',
    'Conference',
    'Workshop',
    'Exhibition',
    'Sports',
    'Other'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _venueController.dispose();
    _imageUrlController.dispose();
    _priceController.dispose();
    _contactController.dispose();
    _eventOwnerController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  InputDecoration _getInputDecoration(String label) {
    return InputDecoration(
    
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87),
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.4),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
    );
  }

@override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedBackgroundWidget(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  colors: [AppColors.accentColor, Colors.white],
                                ).createShader(bounds),
                                child:  Text(
                                  "Create event".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(height: 24),
                          TextFormField(
                            controller: _titleController,
                            decoration: _getInputDecoration('Event Title'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Title is required'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            value: _selectedType,
                            decoration: _getInputDecoration('Event Type'),
                            dropdownColor: Colors.grey.withOpacity(0.4),
                            items: _eventTypes
                                .map((type) => DropdownMenuItem(
                                      value: type,
                                      child: Text(type),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value!;
                              });
                            },
                            validator: (value) => value == null
                                ? 'Please select an event type'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _imageUrlController,
                            decoration: _getInputDecoration('Image URL'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Image URL is required'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _venueController,
                            decoration: _getInputDecoration('Venue'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Venue is required'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: _getInputDecoration('Description'),
                            maxLines: 3,
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Description is required'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color:Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: ListTile(
                              title: Text(
                                'Date: ${_selectedDate.toLocal().toString().split(' ')[0]}',
                                style: const TextStyle(color: Colors.black87),
                              ),
                              trailing: const Icon(Icons.calendar_today),
                              onTap: () => _selectDate(context),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _priceController,
                            decoration: _getInputDecoration('Price').copyWith(
                              prefixText: '',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Price is required';
                              }
                              if (int.tryParse(value!) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _eventOwnerController,
                            decoration: _getInputDecoration('Event Owner'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Event owner is required'
                                : null,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _contactController,
                            decoration: _getInputDecoration('Contact'),
                            validator: (value) => value?.isEmpty ?? true
                                ? 'Contact is required'
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.4),
                      ),
                      child: const Text('Cancel',style: TextStyle(color:AppColors.error),),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final eventData = {
                            'type': _selectedType,
                            'imgUrl': _imageUrlController.text,
                            'venue': _venueController.text,
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                            'date': _selectedDate.toIso8601String(),
                            'price': int.parse(_priceController.text),
                            'eventOwner': _eventOwnerController.text,
                            'contact': _contactController.text,
                          };
                          Navigator.of(context).pop(eventData);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      child: const Text('Create Event'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

