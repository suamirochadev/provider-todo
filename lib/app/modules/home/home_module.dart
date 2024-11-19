import 'package:provider_todo/app/core/modules/todo_module.dart';
import 'package:provider_todo/app/modules/home/home_page.dart';

class HomeModule extends TodoModule {
  HomeModule()
      : super(
        // bindings: [], 
        routers: {
          '/home': (context) => const HomePage(),
        });
}
