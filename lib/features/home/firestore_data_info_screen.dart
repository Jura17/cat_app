import 'package:cat_app/features/auth/data/user_repository.dart';
import 'package:cat_app/features/auth/models/database_user.dart';
import 'package:flutter/material.dart';

class FirestoreDataInfoScreen extends StatefulWidget {
  const FirestoreDataInfoScreen({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  State<FirestoreDataInfoScreen> createState() => _FirestoreDataInfoScreenState();
}

class _FirestoreDataInfoScreenState extends State<FirestoreDataInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder(
            future: widget.userRepository.getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Ein Fehler ist aufgetreten ${snapshot.error}");
              } else if (snapshot.hasData && snapshot.data == null) {
                return Text("Keine Daten vorhanden");
              } else {
                final List<DatabaseUser> allUsers = snapshot.data!;
                return Column(
                  children: [
                    Text("Anzahl registrierter User: ${allUsers.length}"),
                    Expanded(
                      child: ListView.builder(
                        itemCount: allUsers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Text(allUsers[index].name),
                            // title: Text(allUsers[index].age.toString()),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
