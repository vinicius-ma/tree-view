enum AssetType {
  location(name: "location", icon: "location"),
  asset(name: "asset", icon: "asset"),
  component(name: "component", icon: "component"),
  unknown(name: "unknown");

  final String name;
  final String? icon;

  const AssetType({required this.name, this.icon});
}