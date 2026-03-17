import 'package:fiestapp/components/organisation/course-list/course-list.component.dart';
import 'package:fiestapp/components/organisation/expenses/expenses.component.dart';
import 'package:fiestapp/components/organisation/poll/poll.component.dart';
import 'package:fiestapp/components/organisation/where-sleep/where-sleep.component.dart';
import 'package:fiestapp/components/organisation/who-drive/who-drive.component.dart';
import 'package:flutter/material.dart';

class Organisation extends StatefulWidget {
  const Organisation({super.key});

  @override
  State<Organisation> createState() => _OrganisationState();
}

class _OrganisationState extends State<Organisation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Sondage(),
            CouseList(),
            WhoDrive(),
            WhereSleep(),
            Expenses(),
          ],
        ),
      ),
    );
  }
}
