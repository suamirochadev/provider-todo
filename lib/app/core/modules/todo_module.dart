import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider_todo/app/core/modules/todo_page.dart';
// estrutura basica dos nossos routes
abstract class TodoModule {
  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  TodoModule(
      {List<SingleChildWidget>? bindings,
      required Map<String, WidgetBuilder> routers})
      : _routers = routers,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _routers.map((key, pageBuilder) => MapEntry(key, (_) => TodoPage(
      bindings: _bindings,
      page: pageBuilder)));
  }
}
