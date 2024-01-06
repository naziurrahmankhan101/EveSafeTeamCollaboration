import 'package:after_marjana/components/PrimaryButton.dart';
import 'package:flutter/cupertino.dart';

class AddContactsPage extends StatelessWidget {
  const AddContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            PrimaryButton(title: "Add trusted Contacts",onPressed: () {})
          ],
        ),
      ),
    );
  }
}
