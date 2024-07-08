class MyUser {
  static const String collectionName = "users";

  MyUser(
      {this.sap,
      this.name,
      this.id,
      this.role,
      this.email,
      this.active,
      this.password,
      this.token,
      this.job});

  final String? sap;
  final String? name;
  String? id;
  String? token;

  final String? role;
  String? email;
  String? password;

  final bool? active;
  final String? job;

  MyUser.fromFirestore(Map<String, dynamic>? data)
      : this(
            id: data?["id"] as String,
            token: data?["token"] as String?,
            sap: data?["sap"] as String,
            email: data?["email"] as String,
            job: data?["job"] as String,
            active: data?["active"] as bool,
            role: data?["role"] as String,
            name: data?["name"] as String);

  Map<String, dynamic> toFirestore() {
    return {
      "role": role,
      "id": id,
      "sap": sap,
      "token": token,
      "name": name,
      "email": email,
      "active": active,
      "job": job
    };
  }
}
