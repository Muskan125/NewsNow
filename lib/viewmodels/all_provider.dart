import 'package:newsnow/viewmodels/bookmark_view_model.dart';
import 'package:provider/provider.dart';
import 'news_view_model.dart';

class AllProviderList {
  static List<ChangeNotifierProvider> get providers => [
        ChangeNotifierProvider<NewsViewModel>(create: (_) => NewsViewModel()),
        ChangeNotifierProvider<BookmarkViewModel>(create: (_) => BookmarkViewModel()),
      ];
}
