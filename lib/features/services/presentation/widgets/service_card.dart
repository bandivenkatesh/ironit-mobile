/// Service Card Widget for Services Feature
/// Reuses the existing ServiceCard from Home feature
library;

import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/service_card.dart'
    as home_service_card;
import '../../../home/domain/models/service.dart';

class ServiceCard extends StatelessWidget {
  final Service service;
  final VoidCallback? onTap;
  final bool showFavorite;
  final bool isCompact;
  final bool showCategory;

  const ServiceCard({
    super.key,
    required this.service,
    this.onTap,
    this.showFavorite = true,
    this.isCompact = false,
    this.showCategory = false,
  });

  @override
  Widget build(BuildContext context) {
    return home_service_card.ServiceCard(
      service: service,
      onTap: onTap,
      showFavorite: showFavorite,
      isCompact: isCompact,
      showCategory: showCategory,
    );
  }
}
