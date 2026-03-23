import 'package:fiestapp/components/input/data-tag-input.component.dart';
import 'package:fiestapp/constant.dart';
import 'package:fiestapp/core/common_widgets/button/button.component.dart';
import 'package:fiestapp/core/network/client/api_client_provider.dart';
import 'package:fiestapp/enum.dart';
import 'package:fiestapp/feature/event/data/provider/event_details_state.dart';
import 'package:fiestapp/feature/shopping/data/dto/shopping_item_create_dto.dart';
import 'package:fiestapp/feature/shopping/data/shopping_item_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CreateShopItemModal extends ConsumerStatefulWidget {
  const CreateShopItemModal({super.key});

  @override
  ConsumerState<CreateShopItemModal> createState() =>
      _CreateShopItemModalState();
}

class _CreateShopItemModalState extends ConsumerState<CreateShopItemModal> {
  final TextEditingController _quantityController = TextEditingController(
    text: '0',
  );
  final TextEditingController _nameController = TextEditingController();

  late String selectedImage;
  late bool isImageSelectorVisible = false;
  bool isLoading = false;

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

  Future<void> _submit() async {
    final event = ref.read(eventDetailsProvider).event;
    if (event == null) return;

    if (_nameController.text.isEmpty || _quantityController.text == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir tous les champs")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final apiClient = ref.read(apiClientProvider);
      final dto = ShoppingItemCreateDto(
        name: _nameController.text,
        quantity: int.parse(_quantityController.text),
        image: "$S3_enpoint/asset/$selectedImage.webp",
        eventId: event.id,
      );

      await ShoppingItemService.create(apiClient: apiClient, dto: dto);

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Une erreur est survenue")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
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
            const Center(
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
                const SizedBox(width: 20),
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
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  CustomButton(
                    label: 'Ajouter',
                    icon: FontAwesomeIcons.arrowRight,
                    onPressed: _submit,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
