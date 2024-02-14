import 'package:flutter/material.dart';
import 'contract_form.dart';

class MyImageBox extends StatelessWidget {
  final String assetPath;
  final String title;
  final double textFontSize; // New parameter for text font size

  const MyImageBox(this.assetPath, this.title, {Key? key, required this.textFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () {
          _showContractForm(context, title);
        },
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        assetPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: textFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showContractForm(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sign Contract for $title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ContractForm(
                contractTitle: title, // Pass the title to the ContractForm
              ),
            ],
          ),
        );
      },
    );
  }
}
