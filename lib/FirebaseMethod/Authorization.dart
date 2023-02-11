//
//
// class Authorize {
//   Future<String> signUpUser({
//     required String email,
//     required String passWord,
//     required String username,
//     required String bio,
//     required Uint8List file,
//   }) async {
//     String res = "Some error occured";
//     try {
//       if (email.isNotEmpty ||
//           passWord.isNotEmpty ||
//           username.isNotEmpty ||
//           bio.isNotEmpty) {
//         // register the user
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//             email: email, password: passWord);
//         print(cred.user!.uid);
//
//         String photoUrl = await StorageMethods()
//             .uploadImageToStorage('profilePics', file, false);
//         // add user to our database
//
//         model.User user = model.User(
//           username: username,
//           uid: cred.user!.uid,
//           email: email,
//           bio: bio,
//           followers: [],
//           following: [],
//           photoUrl: photoUrl,
//           note: "",
//         );
//
//         await _firestore.collection('users').doc(cred.user!.uid).set(
//           user.toJson(),
//         );
//         res = 'Success';
//       }
//     } on FirebaseAuthException catch (err) {
//       if (err.code == 'invalid-email') {
//         res = 'The email is badly formatted';
//       }
//     } catch (err) {
//       res = err.toString();
//     }
//     return res;
//   }
// }