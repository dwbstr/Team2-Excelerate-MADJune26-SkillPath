import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/program.dart';
import '../services/program_service.dart';
import 'program_detail_screen.dart';

class ProgramListScreen extends StatefulWidget {
  const ProgramListScreen({super.key});

  @override
  State<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen> {
  // 0=All, 1=Popular, 2=Beginner, 3=Intermediate, 4=Advanced
  int _selectedFilter = 0;

  final List<Map<String, String>> _filters = [
    {'label': 'All', 'value': 'all'},
    {'label': '⭐ Popular', 'value': 'popular'},
    {'label': 'Beginner', 'value': 'Beginner'},
    {'label': 'Intermediate', 'value': 'Intermediate'},
    {'label': 'Advanced', 'value': 'Advanced'},
  ];

  List<Program> _allPrograms = [];
  List<Program> _displayPrograms = [];
  bool _isLoading = true;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPrograms();
    _searchController.addListener(_applyFilters);
  }

  @override
  void dispose() {
    _searchController.removeListener(_applyFilters);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchPrograms() async {
    try {
      final data = await ProgramService().fetchPrograms();
      setState(() {
        _allPrograms = data;
        _isLoading = false;
      });
      _applyFilters();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load programs. Please try again.';
        _isLoading = false;
      });
    }
  }

  void _applyFilters() {
    final query = _searchController.text.toLowerCase().trim();
    final filterValue = _filters[_selectedFilter]['value']!;

    List<Program> result = List.from(_allPrograms);

    // Apply level / mode filter
    if (filterValue == 'popular') {
      result.sort((a, b) =>
          double.parse(b.rating).compareTo(double.parse(a.rating)));
    } else if (filterValue != 'all') {
      result = result.where((p) => p.level == filterValue).toList();
    }

    // Apply search query
    if (query.isNotEmpty) {
      result = result
          .where((p) =>
              p.title.toLowerCase().contains(query) ||
              p.description.toLowerCase().contains(query) ||
              p.category.toLowerCase().contains(query))
          .toList();
    }

    setState(() => _displayPrograms = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Programs'),
      ),
      body: Column(
        children: [
          // ── Search Bar ──────────────────────────────────
          Container(
            color: AppTheme.surface,
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search programs, skills, categories...',
                hintStyle:
                    const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                prefixIcon: const Icon(Icons.search_rounded,
                    color: AppTheme.textMuted, size: 20),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded,
                            color: AppTheme.textMuted, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _applyFilters();
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.background,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          // ── Filter Chips ────────────────────────────────
          Container(
            color: AppTheme.surface,
            child: Column(
              children: [
                const Divider(height: 1, color: AppTheme.borderColor),
                SizedBox(
                  height: 48,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    itemCount: _filters.length,
                    itemBuilder: (context, index) {
                      final isSelected = _selectedFilter == index;
                      final color = index == 2
                          ? AppTheme.beginnerColor
                          : index == 3
                              ? AppTheme.intermediateColor
                              : index == 4
                                  ? AppTheme.advancedColor
                                  : AppTheme.dark;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedFilter = index);
                          _applyFilters();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 4),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? color
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected ? color : AppTheme.borderColor,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isSelected) ...[
                                const Icon(Icons.check_rounded,
                                    size: 12, color: Colors.white),
                                const SizedBox(width: 4),
                              ],
                              Text(
                                _filters[index]['label']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.textSecondary,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ── Program List ────────────────────────────────
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: AppTheme.primary))
                : _errorMessage.isNotEmpty
                    ? _buildError()
                    : _displayPrograms.isEmpty
                        ? _buildEmpty()
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                            itemCount: _displayPrograms.length,
                            itemBuilder: (context, index) {
                              return _ProgramCard(
                                program: _displayPrograms[index],
                                onTap: () => Navigator.push(
                                  context,
                                  AppTheme.slideRoute(ProgramDetailScreen(
                                    program: _displayPrograms[index],
                                  )),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded,
                size: 48, color: AppTheme.textMuted),
            const SizedBox(height: 12),
            Text(_errorMessage,
                textAlign: TextAlign.center, style: AppTheme.body),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchPrograms,
              style: AppTheme.primaryButton(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded,
                size: 48, color: AppTheme.textMuted),
            const SizedBox(height: 12),
            const Text('No programs found',
                style: AppTheme.h3),
            const SizedBox(height: 6),
            const Text(
              'Try adjusting your search or changing the filter.',
              textAlign: TextAlign.center,
              style: AppTheme.body,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                _searchController.clear();
                setState(() => _selectedFilter = 0);
                _applyFilters();
              },
              child: const Text('Clear Filters',
                  style: TextStyle(color: AppTheme.primary)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final Program program;
  final VoidCallback onTap;

  const _ProgramCard({required this.program, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final catColor = AppTheme.categoryColor(program.category);
    final levelColor = AppTheme.levelColor(program.level);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppTheme.softShadow,
        ),
        child: Row(
          children: [
            // Thumbnail
            Container(
              width: 88,
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [catColor.withOpacity(0.85), AppTheme.dark.withOpacity(0.8)],
                ),
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(16)),
              ),
              child: Icon(
                AppTheme.categoryIcon(program.category),
                color: Colors.white.withOpacity(0.9),
                size: 34,
              ),
            ),

            // Info
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Level badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: levelColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        program.level,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: levelColor),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      program.title,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      program.description,
                      style: AppTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFFFC107), size: 13),
                        const SizedBox(width: 3),
                        Text(program.rating,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary)),
                        const SizedBox(width: 8),
                        const Icon(Icons.access_time_rounded,
                            size: 12, color: AppTheme.textMuted),
                        const SizedBox(width: 3),
                        Text(program.duration,
                            style: AppTheme.bodySmall
                                .copyWith(fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: AppTheme.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
