import 'package:fiestapp/components/text/custom-subtitlecomponent.dart';
import 'package:fiestapp/components/text/data-tag.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/feature/estimation/data/dto/estimation_dto.dart';
import 'package:fiestapp/feature/estimation/domain/models/estimation.dart';
import 'package:flutter/material.dart';

class SuggestionBloc extends StatelessWidget {
  const SuggestionBloc({super.key, required this.estimation});

  final EstimationDto estimation;

  @override
  Widget build(BuildContext context) {
    final suggestion = Suggestion(
      beer: estimation.beer,
      soft: estimation.softDrink,
      pizza: estimation.pizza,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomSubTitle(title: "Recommandations"),
        Opacity(
          opacity: 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 5,
            children: [
              DataTag(
                s3ImageUrl: "${S3_enpoint}/asset/biere.webp",
                text: "${suggestion.beer} Bières",
              ),
              DataTag(
                s3ImageUrl: "${S3_enpoint}/asset/soda.webp",
                text: "${suggestion.soft} Softs",
              ),
              DataTag(
                s3ImageUrl: "${S3_enpoint}/asset/pizza.webp",
                text: "${suggestion.pizza} Pizzas",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
