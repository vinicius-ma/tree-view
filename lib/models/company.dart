class Company {
  final String id;
  final String name;

  const Company({required this.id, required this.name});

  static List<Company> fromMap(Map<String, List<dynamic>> map) {
    List<Company> companies = [];
    map["companies"]?.forEach((company) {
      companies.add(Company(id: company["id"], name: company["name"]));
    });
    return companies;
  }

}