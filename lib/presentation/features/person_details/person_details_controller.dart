import 'package:film_flu/presentation/features/person_details/person_details_screen.dart';
import 'package:flutter/material.dart';

class PersonDetailsController extends StatefulWidget {
  const PersonDetailsController({
    super.key,
    required this.personId,
  });

  final String personId;

  @override
  State<PersonDetailsController> createState() =>
      _PersonDetailsControllerState();
}

class _PersonDetailsControllerState extends State<PersonDetailsController> {
  @override
  Widget build(BuildContext context) {
    return PersonDetailsPage(personId: widget.personId);
  }
}
