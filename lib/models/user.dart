class Customer {
  final int id;
  final String fullname;
  final String email;
  final String role;
  final String createdAt;

  Customer({
    required this.id,
    required this.fullname,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      role: json['role'],
      createdAt: json['createdAt'],
    );
  }
}
