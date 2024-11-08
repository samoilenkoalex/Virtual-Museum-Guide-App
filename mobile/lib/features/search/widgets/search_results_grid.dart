import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/search_bloc.dart';

class SearchResultsGrid extends StatelessWidget {
  const SearchResultsGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is SearchLoading) {
        return const CircularProgressIndicator();
      } else if (state is SearchLoaded) {
        return Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10, // Horizontal space between items
                mainAxisSpacing: 10, // Vertical space between items
                childAspectRatio: 0.75, // Aspect ratio of each grid item (width / height)
              ),
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final artwork = state.result[index];
                return artwork.primaryImage.isNotEmpty
                    ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      artwork.primaryImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : const SizedBox(); // Empty container for items without images
              },
            )
        );
      } else {
        return const Text('Search for artwork');
      }
    });
  }
}