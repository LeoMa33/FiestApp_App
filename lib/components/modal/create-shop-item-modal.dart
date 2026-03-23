import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/enum.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateShopItemModal extends StatefulWidget {
  const CreateShopItemModal({super.key});

  @override
  State<CreateShopItemModal> createState() => _CreateShopItemModalState();
}

class _CreateShopItemModalState extends State<CreateShopItemModal> {
  final TextEditingController _quantityController = TextEditingController(
    text: '0',
  );
  final TextEditingController _nameController = TextEditingController();

  late String selectedImage;
  late bool isImageSelectorVisible = false;

  final List<String> imagesName = [
    "assiette",
    "biere",
    "boisson_energisante",
    "bonbon",
    "cacahuette",
    "chips",
    "citron",
    "cookie",
    "cornichon",
    "couvert",
    "croissant",
    "eau",
    "fromage",
    "glace",
    "glacon",
    "gobelet",
    "grillade",
    "jet",
    "jus_de_fruit",
    "nappe",
    "olive",
    "pain",
    "pizza",
    "carotte",
    "rhum",
    "ricard",
    "sac_poubelle",
    "saucisson",
    "serviette",
    "sirop",
    "soda",
    "sucre",
    "tomate",
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedImage = "pizza";
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.95,
        minWidth: MediaQuery.of(context).size.width * 0.95,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Center(
              child: Text(
                "Ajout d'un article",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        isImageSelectorVisible = !isImageSelectorVisible;
                      }),
                      child: Image.network(
                        "$S3_enpoint/asset/$selectedImage.webp",
                        height: 80,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.pen,
                          size: 20,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    spacing: 20,
                    children: [
                      DataTagInput(
                        title: "Nom de l'article",
                        placeholder: "Nom de l'article",
                        inputType: InputType.text,
                        controller: _nameController,
                      ),
                      DataTagInput(
                        title: 'Quantité',
                        placeholder: '0',
                        inputType: InputType.counter,
                        controller: _quantityController,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isImageSelectorVisible)
              Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final imageName in imagesName)
                        if (imageName != selectedImage)
                          GestureDetector(
                            onTap: () => setState(() {
                              selectedImage = imageName;
                              isImageSelectorVisible = false;
                            }),
                            child: Image.network(
                              "$S3_enpoint/asset/$imageName.webp",
                              height: 48,
                            ),
                          ),
                    ],
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                  label: 'Ajouter',
                  icon: FontAwesomeIcons.arrowRight,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
