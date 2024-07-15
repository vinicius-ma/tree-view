enum AssetType {
  location(name: "location", icon: "location"),
  asset(name: "asset", icon: "asset"),
  component(name: "component", icon: "component");

  final String name;
  final String icon;

  const AssetType({required this.name, required this.icon});
}