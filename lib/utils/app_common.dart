import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppCommon {
  static messageDialog(String message) async {
    return toastification.showCustom(
      animationDuration: const Duration(milliseconds: 500),
      autoCloseDuration: const Duration(seconds: 5),
      builder: (context, holder) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: const Border(
                    top: BorderSide(
                      color: Colors.red,
                      width: 3,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 25,
                    )
                  ],
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.warning_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Heads Up !!",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            message,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      const Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}
