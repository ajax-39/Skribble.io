import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scriclone/views/paint_screen.dart';
import 'package:scriclone/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  String? _maxRoundsValue;
  String? _roomSizeValue;

  void createRoom() {
    if (_nameController.text.isNotEmpty &&
        _roomNameController.text.isNotEmpty &&
        _maxRoundsValue != null &&
        _roomSizeValue != null) {
      Map<String, String> data = {
        "nickname": _nameController.text,
        "name": _roomNameController.text,
        "occupancy": _roomSizeValue!,
        "maxRounds": _maxRoundsValue!
      };
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PaintScreen(data: data, screenFrom: 'createRoom')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Create Room",
                  style: GoogleFonts.pressStart2p(textStyle: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)) ,
                ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  controller: _nameController,
                  hintText: "Enter Your Name",
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  controller: _roomNameController,
                  hintText: "Enter Room Name",
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: _maxRoundsValue, // Set the current value of the dropdown
                focusColor: const Color(0xff5f56fa),
                hint: const Text(
                  'Select Max Rounds',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                items: <String>["2", "5", "10", "15"]
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem(
                        value: value, // Set the value for each item
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _maxRoundsValue = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButton<String>(
                value: _roomSizeValue, // Set the current value of the dropdown
                focusColor: const Color(0xff5f56fa),
                hint: const Text(
                  'Select Room Size',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                items: <String>["2", "3", "4", "5", "6", "7", "8"]
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem(
                        value: value, // Set the value for each item
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _roomSizeValue = value;
                  });
                },
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: createRoom,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.resolveWith((states) => Colors.blue),
                  textStyle: WidgetStateProperty.resolveWith<TextStyle>(
                    (states) => TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                  minimumSize: WidgetStateProperty.resolveWith<Size>(
                    (states) => Size(
                      MediaQuery.of(context).size.width / 2.5,
                      50,
                    ),
                  ),
                ),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
