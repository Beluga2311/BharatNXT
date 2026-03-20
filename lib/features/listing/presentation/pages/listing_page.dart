import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bharatnxt/core/di/injector.dart';
import 'package:bharatnxt/core/widgets/theme_toggle_button.dart';
import 'package:bharatnxt/features/listing/domain/repositories/suggestion_repository.dart';
import 'package:bharatnxt/features/listing/domain/usecases/get_suggestions_usecase.dart';
import 'package:bharatnxt/features/listing/presentation/bloc/listing_bloc.dart';
import 'package:bharatnxt/features/listing/presentation/widgets/pagination_controls.dart';
import 'package:bharatnxt/features/listing/presentation/widgets/suggestion_card.dart';

class ListingPage extends StatelessWidget {
  const ListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListingBloc>(
      create: (_) => ListingBloc(
        GetSuggestionsUseCase(sl<SuggestionRepository>()),
      )..add(const LoadSuggestionsEvent()),
      child: const _ListingPageContent(),
    );
  }
}

class _ListingPageContent extends StatefulWidget {
  const _ListingPageContent();

  @override
  State<_ListingPageContent> createState() => _ListingPageContentState();
}

class _ListingPageContentState extends State<_ListingPageContent> {
  final _pageController = TextEditingController(text: '1');
  final _limitController = TextEditingController(text: '10');

  @override
  void dispose() {
    _pageController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  void _fetch() {
    final page = int.tryParse(_pageController.text.trim());
    final limit = int.tryParse(_limitController.text.trim());

    if (page == null || page < 1) {
      _showError('Page must be a number ≥ 1.');
      return;
    }
    if (limit == null || limit < 1 || limit > 100) {
      _showError('Limit must be a number between 1 and 100.');
      return;
    }

    context.read<ListingBloc>().add(
          LoadSuggestionsEvent(page: page, limit: limit),
        );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cs.inversePrimary,
        title: const Text('Suggestions'),
        actions: const [ThemeToggleButton()],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: cs.surfaceContainerLow,
              border: Border(bottom: BorderSide(color: cs.outlineVariant)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: _NumberField(
                    controller: _pageController,
                    label: 'Page',
                    hint: 'e.g. 1',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumberField(
                    controller: _limitController,
                    label: 'Limit',
                    hint: 'e.g. 10',
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: _fetch,
                  child: const Text('Fetch'),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocConsumer<ListingBloc, ListingState>(
              listener: (context, state) {
                if (state is ListingLoadedState) {
                  _pageController.text =
                      '${state.pagination.currentPage}';
                  _limitController.text = '${state.pagination.limit}';
                }
              },
              builder: (context, state) {
                if (state is ListingLoadingState ||
                    state is ListingInitialState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ListingErrorState) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.error_outline_rounded,
                            size: 56, color: cs.error),
                        const SizedBox(height: 12),
                        Text(
                          state.message,
                          style: TextStyle(color: cs.error),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        FilledButton.tonal(
                          onPressed: _fetch,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is! ListingLoadedState) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            '${state.pagination.totalItems} suggestions',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant,
                                    ),
                          ),
                          const Spacer(),
                          Text(
                            'Page ${state.pagination.currentPage} of ${state.pagination.totalPages}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: cs.onSurfaceVariant,
                                    ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 8),
                        itemCount: state.suggestions.length,
                        itemBuilder: (context, i) =>
                            SuggestionCard(suggestion: state.suggestions[i]),
                      ),
                    ),

                    const Divider(height: 1),
                    PaginationControls(
                      pagination: state.pagination,
                      onPageSelected: (page) =>
                          context.read<ListingBloc>().add(GoToPageEvent(
                                page: page,
                                limit: state.pagination.limit,
                              )),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;

  const _NumberField({
    required this.controller,
    required this.label,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: cs.surface,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}
