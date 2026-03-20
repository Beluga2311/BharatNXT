import 'package:bharatnxt/features/listing/data/datasources/suggestion_datasource.dart';
import 'package:bharatnxt/features/listing/data/models/suggestions_result_model.dart';

class SuggestionMockDataSource implements SuggestionDataSource {
  static const _totalItems = 50;

  static const List<Map<String, dynamic>> _allSuggestions = [
    {'id': 1, 'title': 'Summarize my notes', 'description': 'Get a concise summary of your text'},
    {'id': 2, 'title': 'Generate email reply', 'description': 'Create a professional email response'},
    {'id': 3, 'title': 'Bulk order capacitors', 'description': 'Source 10,000+ capacitors from verified suppliers'},
    {'id': 4, 'title': 'Find resistor suppliers', 'description': 'Locate bulk resistor vendors across India'},
    {'id': 5, 'title': 'Compare IC prices', 'description': 'Get competitive quotes for integrated circuits'},
    {'id': 6, 'title': 'Track shipment status', 'description': 'Real-time updates on your component orders'},
    {'id': 7, 'title': 'Request product samples', 'description': 'Order trial batches before bulk purchase'},
    {'id': 8, 'title': 'Verify supplier credentials', 'description': 'Check ISI/ISO certification of vendors'},
    {'id': 9, 'title': 'Negotiate bulk discounts', 'description': 'Get 10–15% off for orders above 5,000 units'},
    {'id': 10, 'title': 'Set up payment terms', 'description': 'Configure Net 30/60 or escrow payment options'},
    {'id': 11, 'title': 'Find LED strip suppliers', 'description': 'Source addressable LED strips in bulk'},
    {'id': 12, 'title': 'Order PCB components', 'description': 'Get all components for your PCB assembly'},
    {'id': 13, 'title': 'Schedule delivery', 'description': 'Book express or standard shipping slots'},
    {'id': 14, 'title': 'Calculate order cost', 'description': 'Estimate total cost with shipping and taxes'},
    {'id': 15, 'title': 'Browse transformer specs', 'description': 'Filter transformers by voltage and wattage'},
    {'id': 16, 'title': 'Source relay modules', 'description': 'Find 5V and 12V relay modules in quantity'},
    {'id': 17, 'title': 'Find MOSFET suppliers', 'description': 'Locate N-channel and P-channel MOSFET vendors'},
    {'id': 18, 'title': 'Export order report', 'description': 'Download CSV summary of all your orders'},
    {'id': 19, 'title': 'Check stock availability', 'description': 'See real-time inventory from multiple suppliers'},
    {'id': 20, 'title': 'Register as a buyer', 'description': 'Create a verified buyer profile on BharatNxt'},
    {'id': 21, 'title': 'Add to watchlist', 'description': 'Track price changes on specific components'},
    {'id': 22, 'title': 'Set reorder alerts', 'description': 'Get notified when stock drops below threshold'},
    {'id': 23, 'title': 'Find Arduino suppliers', 'description': 'Source Arduino boards and shields in bulk'},
    {'id': 24, 'title': 'Source Raspberry Pi', 'description': 'Locate verified distributors for SBCs'},
    {'id': 25, 'title': 'Get customs clearance help', 'description': 'Assistance with import documentation'},
    {'id': 26, 'title': 'Find diode suppliers', 'description': 'Source Schottky and Zener diodes in bulk'},
    {'id': 27, 'title': 'Order inductors', 'description': 'Browse ferrite core inductors by inductance'},
    {'id': 28, 'title': 'Source connectors', 'description': 'Find JST, Dupont, and XT connectors in bulk'},
    {'id': 29, 'title': 'Compare shipping rates', 'description': 'View courier rates for different delivery zones'},
    {'id': 30, 'title': 'List your products', 'description': 'Register as a supplier and list components'},
    {'id': 31, 'title': 'Manage invoices', 'description': 'View and download GST-compliant invoices'},
    {'id': 32, 'title': 'Find oscillator suppliers', 'description': 'Source crystal oscillators by frequency'},
    {'id': 33, 'title': 'Source fuses and breakers', 'description': 'Find protection components for circuits'},
    {'id': 34, 'title': 'Browse power modules', 'description': 'DC-DC converters and voltage regulators'},
    {'id': 35, 'title': 'Order wire harnesses', 'description': 'Custom wiring assemblies for your design'},
    {'id': 36, 'title': 'Find motor driver ICs', 'description': 'L298N and DRV8833 driver ICs in quantity'},
    {'id': 37, 'title': 'Source sensors in bulk', 'description': 'Temperature, humidity, and proximity sensors'},
    {'id': 38, 'title': 'Find display modules', 'description': 'OLED, TFT, and LCD displays wholesale'},
    {'id': 39, 'title': 'Order battery packs', 'description': 'Li-ion and LiFePO4 cells in bulk'},
    {'id': 40, 'title': 'Source RF modules', 'description': 'LoRa, NRF24L01, and Bluetooth modules'},
    {'id': 41, 'title': 'Compare solder quality', 'description': 'Find lead-free solder in bulk reels'},
    {'id': 42, 'title': 'Order ESD protection bags', 'description': 'Anti-static packaging for component storage'},
    {'id': 43, 'title': 'Find tooling suppliers', 'description': 'SMD rework stations and hot air guns'},
    {'id': 44, 'title': 'Source thermal paste', 'description': 'Heatsink compound for power electronics'},
    {'id': 45, 'title': 'Find enclosure suppliers', 'description': 'Plastic and metal enclosures for PCBs'},
    {'id': 46, 'title': 'Order PCB prototypes', 'description': 'Get Gerber files manufactured in 24–48 hours'},
    {'id': 47, 'title': 'Source BGA components', 'description': 'Ball grid array ICs with X-ray inspection'},
    {'id': 48, 'title': 'Find through-hole parts', 'description': 'THT resistors, caps, and ICs in bulk bags'},
    {'id': 49, 'title': 'Manage returns', 'description': 'Raise return requests for defective stock'},
    {'id': 50, 'title': 'Contact supplier directly', 'description': 'Chat with verified suppliers on BharatNxt'},
  ];

  @override
  Future<SuggestionsResultModel> getSuggestions({
    required int page,
    required int limit,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (limit < 1 || limit > 100) {
      throw RangeError('Limit must be between 1 and 100 (got $limit).');
    }

    final totalPages = (_totalItems / limit).ceil();

    if (page < 1 || page > totalPages) {
      throw RangeError(
        'Page $page is out of range. Valid range: 1–$totalPages for limit $limit.',
      );
    }

    final startIndex = (page - 1) * limit;
    final endIndex = (startIndex + limit).clamp(0, _totalItems);
    final pageItems = _allSuggestions.sublist(startIndex, endIndex);

    return SuggestionsResultModel.fromJson({
      'suggestions': pageItems,
      'pagination': {
        'current_page': page,
        'total_pages': totalPages,
        'total_items': _totalItems,
        'limit': limit,
        'has_next': page < totalPages,
        'has_previous': page > 1,
      },
    });
  }
}
