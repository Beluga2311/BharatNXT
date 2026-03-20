abstract class PaginationMeta {
  int get currentPage;
  int get totalPages;
  int get totalItems;
  int get limit;
  bool get hasNext;
  bool get hasPrevious;
}
