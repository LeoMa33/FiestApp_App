import 'package:fiestapp/components/custom-card/illustration-card/illustration-card.component.dart';
import 'package:fiestapp/components/modal/create-shop-item-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:flutter/material.dart';

class CourseListGrid extends StatefulWidget {
  const CourseListGrid({super.key});

  @override
  State<CourseListGrid> createState() => _CourseListGridState();
}

class _CourseListGridState extends State<CourseListGrid> {
  Future<void> onClick() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(child: CreateShopItemModal());
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
          imageSize: 50,
          s3ImageUrl: "${S3_enpoint}asset/eau.webp",
          principalLabel: '2',
          secondaryLabel: 'Eau',
        ),
        IllustrationCard(
          imageSize: 50,
          s3ImageUrl: "${S3_enpoint}asset/biere.webp",
          principalLabel: '10',
          secondaryLabel: 'Biere',
        ),
        IllustrationCard(
          imageSize: 50,
          s3ImageUrl: "${S3_enpoint}asset/pizza.webp",
          principalLabel: '3',
          secondaryLabel: 'Pizza',
        ),
        IllustrationCard(
          imageSize: 50,
          s3ImageUrl: "${S3_enpoint}asset/chips.webp",
          principalLabel: '4',
          secondaryLabel: 'Paquet de chips',
        ),
      ],
    );
  }
}
