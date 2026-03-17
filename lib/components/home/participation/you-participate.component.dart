import 'package:fiestapp/components/custom-card/you-participate/you-participate-card.component.dart';
import 'package:fiestapp/components/text/custom-title.component.dart';
import 'package:fiestapp/provider/event/event.provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YouParticipate extends ConsumerStatefulWidget {
  const YouParticipate({super.key});

  @override
  ConsumerState<YouParticipate> createState() => _YouParticipateState();
}

class _YouParticipateState extends ConsumerState<YouParticipate> {
  @override
  Widget build(BuildContext context) {
    final events = ref.watch(eventProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 10,
      children: [
        CustomTitle(text: "Vous y participez"),
        ...events.map((event) => YouParticipateCard(event: event)),
      ],
    );
  }
}
