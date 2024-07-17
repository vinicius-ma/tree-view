enum AssetType {
  location(name: "location", icon: "location"),
  asset(name: "asset", icon: "asset"),
  component(name: "component", icon: "component"),
  unknown(name: "unknown", icon:"error");

  final String name;
  final String? icon;

  const AssetType({required this.name, required this.icon});
}