import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContractForm extends StatefulWidget {
  final String contractTitle;

  const ContractForm({Key? key, required this.contractTitle}) : super(key: key);

  @override
  _ContractFormState createState() => _ContractFormState();
}

class _ContractFormState extends State<ContractForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contractController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Your Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: contractController,
          decoration: InputDecoration(
            labelText: 'Contact Number',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: remarksController,
          decoration: InputDecoration(
            labelText: 'Additional Remarks',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isLoading ? null : () async {
            // Get the current user's email
            String senderEmail = FirebaseAuth.instance.currentUser!.email!;
            _submitForm(
              context,
              nameController.text,
              contractController.text,
              remarksController.text,
              widget.contractTitle,
              senderEmail, // Pass sender's email to _submitForm
            );
          },
          child: _isLoading ? CircularProgressIndicator() : Text('Submit'),
        ),
      ],
    );
  }

  void _submitForm(
      BuildContext context,
      String name,
      String contract,
      String remarks,
      String title,
      String senderEmail,
      ) async {
    if (name.isEmpty || contract.isEmpty || remarks.isEmpty) {
      // Show an error toast if any field is empty
      Fluttertoast.showToast(
        msg: 'Please fill out all fields.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastSubmitTimestamp = prefs.getInt('last_submit_timestamp') ?? 0;
    int currentTime = DateTime.now().millisecondsSinceEpoch;

    // Define your submission limit duration (e.g., 1 minute)
    const int submissionLimitDuration = 120000; // 24 hours in milliseconds

    if (currentTime - lastSubmitTimestamp < submissionLimitDuration) {
      Fluttertoast.showToast(
        msg: 'You already sent us a request. Please wait, and we will contact you.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final CollectionReference contracts =
      FirebaseFirestore.instance.collection('contracts');

      // Use sender's email as document ID
      await contracts.doc(senderEmail).set({
        'name': name,
        'contract': contract,
        'remarks': remarks,
        'contractTitle': title,
      });

      // Store the timestamp of the current submission
      await prefs.setInt('last_submit_timestamp', currentTime);

      Navigator.pop(context);

      // Show a custom-styled professional toast for success
      Fluttertoast.showToast(
        msg: 'Your Request submitted successfully!',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (error) {
      // Handle error

      // Show an error toast with custom styling
      Fluttertoast.showToast(
        msg: 'Failed to submit data. Please check your permissions and try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

}
