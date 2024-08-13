class Warehouse {
  Warehouse({required this.id, required this.name});
  final int id;
  final String name;

  factory Warehouse.fromJson(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final name = data['name'] as String;
    return Warehouse(id: id, name: name);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class GetWarehouses {
  GetWarehouses({required this.warehouses});
  final List<Warehouse> warehouses;

  factory GetWarehouses.fromJson(Map<String, dynamic> data) {
    final warehousesData = data['warehouses'] as List<dynamic>;
    final warehouses = warehousesData
        .map((whData) => Warehouse.fromJson(whData))
        .toList();

    return GetWarehouses(warehouses: warehouses);
  }
}
