import 'package:fiestapp/components/organisation/expenses/expenses-grid.component.dart';
import 'package:fiestapp/components/organisation/expenses/total-bloc.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void onClick() {
    print("Expenses onClick called");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomTitleExpand(
          title: "Dépenses",
          text: "Tout voir",
          onClick: onClick,
        ),
        TotalBloc(total: 137.52),
        ExpensesGrid(),
      ],
    );
  }
}
