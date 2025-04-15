import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  /*
SERIALIZATION : convert user models to Map
  why : converting to a map is an intermediate step that makes it easier to serialize
  the map object to formates like Json for storage or transmission
*/

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
      "token": token,
    };
  }

  /*
  SERIALIZATION : convert map data models to json string
  The json.encode() function converts a dart object (such as Map/List)
  into a Json String representation, making it suitable for communication
  between different systems
  */
  String toJson() => json.encode(toMap());

  /*
  Deserialization: convert a Map to a User Object
  purpose : Manipulation and user: once the data is converted to a user object
  it can be easily manipulated and use within the application. 
  for ex: we want to display the user's fullname, email , etc on UI / store
  the data to local data
  */

  /*
the factory constructor takes a Map(Usually obtained from a json object)
 then convert it into a user object. if the field is not present it will be
 default empty string

fromMap : this constructor take a Map<String, dynamic> and convert into a user
object. Its usefull when you already have the data in map format
from API

fromJson : this constructor takes Json String, and decodes into a Map<String, dynamic>
then uses fromMap to convert map into user object
*/

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
