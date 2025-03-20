import 'package:film_flu/app/extensions/localizations_extensions.dart';
import 'package:film_flu/domain/models/search_result_entity.dart';
import 'package:film_flu/presentation/features/search/widgets/search_result_view.dart';
import 'package:film_flu/presentation/view_models/searched_media_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  // The query currently being searched for. If null, there is no pending
  // request.
  String? _searchingWithQuery;

  // The most recent options received from the API.
  late Iterable<SearchResultView> _lastOptions = <SearchResultView>[];

  @override
  Widget build(BuildContext context) {
    String languageName = context.localizations.localeName;

    return SearchAnchor(
      suggestionsBuilder: (
        BuildContext context,
        SearchController controller,
      ) async {
        _searchingWithQuery = controller.text;
        final options = await ref
            .read(searchMediaListProvider.notifier)
            .search(languageName, controller.text);

        // If another search happened after this one, throw away these options.
        // Use the previous options instead and wait for the newer request to
        // finish.
        if (_searchingWithQuery != controller.text) {
          return _lastOptions;
        }

        _lastOptions = List<SearchResultView>.generate(options.length, (
          int index,
        ) {
          final SearchResultEntity searchResult = options[index];
          return SearchResultView(
            searchResult: searchResult,
            controller: controller,
          );
        });

        return _lastOptions;
      },
      builder: (context, controller) {
        return SearchBar(
          textInputAction: TextInputAction.search,
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 8.0),
          ),
          onTap:
              () =>
                  !controller.isOpen && _lastOptions.isNotEmpty
                      ? controller.openView()
                      : null,
          onTapOutside:
              (event) => controller.isOpen ? controller.closeView(null) : null,
          onSubmitted: (value) {},
          onChanged: (value) async {
            Future.delayed(const Duration(milliseconds: 2000), () async {
              await ref
                  .read(searchMediaListProvider.notifier)
                  .search(value, languageName);
              if (!controller.isOpen) controller.openView();
            });
          },
          leading: Icon(Icons.search),
          hintText: context.localizations.search,
        );
      },
    );
  }
}
