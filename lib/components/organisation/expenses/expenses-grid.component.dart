import 'package:fiestapp/components/custom-card/illustration-card/illustration-card.component.dart';
import 'package:fiestapp/components/modal/create-expense-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:flutter/material.dart';

class ExpensesGrid extends StatefulWidget {
  const ExpensesGrid({super.key});

  @override
  State<ExpensesGrid> createState() => _ExpensesGridState();
}

class _ExpensesGridState extends State<ExpensesGrid> {
  Future<void> onClick() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(child: CreateExpenseModal());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 0.70,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        AddCard(height: 4, width: 20, radius: 30, onClick: onClick),
        IllustrationCard(
          s3ImageUrl: "${S3_enpoint}user/user.webp",
          isUser: true,
          imageSize: 50,
          principalLabel: '20€',
          secondaryLabel: 'Eau',
        ),
        IllustrationCard(
          s3ImageUrl: "${S3_enpoint}user/user.webp",
          isUser: true,
          imageSize: 50,
          principalLabel: '10€',
          secondaryLabel: 'Biere',
        ),
        IllustrationCard(
          s3ImageUrl: "${S3_enpoint}user/user.webp",
          isUser: true,
          imageSize: 50,
          principalLabel: '3€',
          secondaryLabel: 'Pizza',
        ),
        IllustrationCard(
          s3ImageUrl: "${S3_enpoint}user/user.webp",
          isUser: true,
          imageSize: 50,
          principalLabel: '4.50€',
          secondaryLabel: 'Paquet de chips',
        ),
      ],
    );
  }
}
