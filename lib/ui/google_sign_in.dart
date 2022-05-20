import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:avatar_glow/avatar_glow.dart';

class MyGoogleSignIn extends StatefulWidget {
  const MyGoogleSignIn({Key? key}) : super(key: key);

  @override
  State<MyGoogleSignIn> createState() => _MyGoogleSignInState();
}

class _MyGoogleSignInState extends State<MyGoogleSignIn> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? user;

  Future<GoogleSignInAccount?> googleSignIn() async{
    if(user != null){
      return user;
    }
    else{
      await _googleSignIn.signIn();
      return _googleSignIn.currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
          child: FutureBuilder(
            future: googleSignIn(),
            builder: (BuildContext context, AsyncSnapshot<GoogleSignInAccount?> snapshot) {
                if(snapshot.hasData){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AvatarGlow(
                        endRadius: 60.0,
                        glowColor: Colors.red,
                        child: Material(     // Replace this child with your own
                          elevation: 8.0,
                          shape: const CircleBorder(),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100],
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(const Radius.circular(100)),
                              child: Image.asset(
                                user != null? user!.photoUrl! : 'assets/google_avatar.jpg',
                                height: 50,
                              ),
                            ),
                            radius: 30.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(user != null ? user!.email : snapshot.data!.email),
                      const SizedBox(height: 16),
                      Text(user != null ? user!.displayName! : snapshot.data!.displayName!),
                      TextButton(
                          onPressed: () {
                            _googleSignIn.signOut();
                            setState(() {

                            });
                          },
                          child: const Text('Sign out'))
                    ],
                  );
                }
                else {
                  return const Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                  );
                }
              },
          ),
        ),
    );
  }
}
