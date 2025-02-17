class DeliveryAgentEntity {
  const DeliveryAgentEntity({
    required this.id,
    required this.email,
    required this.phone,
    required this.name,
    required this.lastname,
  });
  final String id;
  final String email;
  final String phone;
  final String name;
  final String lastname;

  const DeliveryAgentEntity.empty()
      : id = '',
        email = '',
        phone = '',
        name = '',
        lastname = '';
}
