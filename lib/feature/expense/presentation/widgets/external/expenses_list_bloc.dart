import 'package:fiestapp/components/custom-card/illustration-card/illustration-card.component.dart';
import 'package:fiestapp/components/modal/create-expense-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:fiestapp/core/network/s3_service.dart';
import 'package:fiestapp/feature/expense/data/dto/expense_dto.dart';
import 'package:fiestapp/feature/expense/presentation/widgets/external/total_bloc.dart';
import 'package:flutter/material.dart';

class ExpenseListBloc extends StatelessWidget {
  const ExpenseListBloc({super.key, required this.expenses});

  final List<ExpenseDto> expenses;

  void onClick() {
    print("Expenses onClick called");
  }

  Future<void> createExpense(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(child: CreateExpenseModal());
      },
    );
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
        TotalBloc(total: expenses.fold(0.0, (sum, item) => sum + item.amount)),
        GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.70,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            AddCard(
              height: 4,
              width: 20,
              radius: 30,
              onClick: () => createExpense(context),
            ),
            ...expenses.map(
              (expense) => IllustrationCard(
                s3ImageUrl: S3Service.getUserImage(expense.author.imageUrl),
                isUser: true,
                imageSize: 50,
                principalLabel: '${expense.amount.toStringAsFixed(2)}€',
                secondaryLabel: expense.name,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
