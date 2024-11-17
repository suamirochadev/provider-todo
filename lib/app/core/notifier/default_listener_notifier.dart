import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider_todo/app/core/notifier/default_change_notifier.dart';
import 'package:provider_todo/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  final DefaultChangeNotifier changeNotifier;

  void listener({
    required BuildContext context,
    required SuccessVoidCallback? successCallback,
    ErrorVoidCallback? errorCallback,
    EverVoidCallback? everCallback,
  }) {
    changeNotifier.addListener(() {
      if (everCallback != null) {
        everCallback(changeNotifier, this);
      }

      if (changeNotifier.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallback != null) {
          errorCallback(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSuccess) {
        if (successCallback != null) {
          successCallback(changeNotifier, this);
        }
        Messages.of(context)
            .showInfo(changeNotifier.successMessage ?? 'Entre com o seu login');
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SuccessVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);

typedef ErrorVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);
typedef EverVoidCallback = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);
