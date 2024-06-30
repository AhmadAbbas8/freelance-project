import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/icon_broken.dart';

import '../../../core/cache_helper/cache_storage.dart';
import '../../../core/cache_helper/shared_prefs_keys.dart';
import '../../../core/service_locator/service_locator.dart';
import '../../auth/data/user_model.dart';
import '../data/model/project_model.dart';

class OffersItemWidget extends StatelessWidget {
  final Offers offers;

  const OffersItemWidget({
    super.key,
    required this.offers,
    required this.onAccept,
  });

  final VoidCallback onAccept;

  @override
  Widget build(BuildContext context) {
    var userJson = ServiceLocator.instance<CacheStorage>()
        .getData(key: SharedPrefsKeys.user);
    var userDecoded = json.decode(userJson);
    var user = UserModel.fromJson(userDecoded);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              offers.status == 'Rejected'
                  ? Icons.close
                  : offers.status == 'Pending'
                      ? Icons.pending_actions
                      : Icons.check,
              color: offers.status == 'Rejected'
                  ? Colors.red
                  : offers.status == 'Pending'
                      ? Colors.orangeAccent
                      : Colors.green,
              size: 30,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offers.providerName ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    offers.message ?? '',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${offers.status}',
                    style: TextStyle(
                      fontSize: 14,
                      color: offers.status == 'Rejected'
                          ? Colors.red
                          : offers.status == 'Pending'
                              ? Colors.orangeAccent
                              : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            if (user.role == 'Customer')
              IconButton.outlined(
                onPressed: onAccept,
                icon: const Icon(Icons.done),
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
