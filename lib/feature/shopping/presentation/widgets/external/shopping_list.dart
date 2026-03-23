import 'package:fiestapp/components/custom-card/illustration-card/illustration-card.component.dart';
import 'package:fiestapp/components/modal/create-shop-item-modal.dart';
import 'package:fiestapp/components/organisation-item/add.component.dart';
import 'package:fiestapp/components/text/custom-title-expand.component.dart';
import 'package:fiestapp/feature/estimation/data/dto/estimation_dto.dart';
import 'package:fiestapp/feature/estimation/presentation/widgets/external/suggestion_bloc.dart';
import 'package:fiestapp/feature/shopping/data/dto/shopping_item_dto.dart';
import 'package:flutter/material.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({
    super.key,
    required this.shoppingItems,
    required this.estimation,
  });

  final List<ShoppingItemDto> shoppingItems;
  final EstimationDto estimation;

  void onClick() {
    print("CourseList");
  }

  Future<void> createShoppingItem(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return const Dialog(child: CreateShopItemModal());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CustomTitleExpand(
          title: "Liste de courses",
          text: "Tout voir",
          onClick: onClick,
        ),
        SuggestionBloc(estimation: estimation),
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
              onClick: () => createShoppingItem(context),
            ),
            ...shoppingItems.map(
              (item) => IllustrationCard(
                imageSize: 50,
                s3ImageUrl: item.image,
                principalLabel: item.quantity.toString(),
                secondaryLabel: item.name,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
