import '../models/user_model.dart';

/// Authentication Service with placeholder methods
///
/// Students will implement all authentication operations here
/// This teaches them:
/// - User registration with email/password
/// - User login
/// - User logout
/// - Storing additional user data in Firestore
/// - User profile management
class AuthService {
  // TODO: Initialize Firebase Auth instance
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  // TODO: Initialize Firestore instance
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get current user
  ///
  /// TODO: Students will implement this
  /// - Return current user from FirebaseAuth
  /// - If user exists, fetch additional data from Firestore 'users' collection
  /// - Return UserModel with all user information
  UserModel? getCurrentUser() {
    // TODO: Get current user from FirebaseAuth
    // TODO: If user exists, fetch from Firestore 'users' collection
    // TODO: Return UserModel.fromMap() or null
    throw UnimplementedError('Students need to implement getCurrentUser()');
  }

  /// Stream of authentication state changes
  ///
  /// TODO: Students will implement this
  /// - Use FirebaseAuth authStateChanges() stream
  /// - When user logs in, fetch user data from Firestore
  /// - When user logs out, return null
  Stream<UserModel?> get authStateChanges {
    // TODO: Return stream that listens to auth state changes
    // TODO: Map auth user to UserModel by fetching from Firestore
    throw UnimplementedError('Students need to implement authStateChanges');
  }

  /// Sign up a new user
  ///
  /// TODO: Students will implement this
  /// Steps:
  /// 1. Create user with email/password using FirebaseAuth.createUserWithEmailAndPassword()
  /// 2. Create user document in Firestore 'users' collection with additional info
  /// 3. Set displayName in FirebaseAuth user profile
  /// 4. Return UserModel
  ///
  /// This teaches:
  /// - User registration
  /// - Storing additional user data in separate collection
  /// - Linking Auth user with Firestore document
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    String? bio,
    String? address,
  }) async {
    // TODO: Step 1: Create user with FirebaseAuth
    // final userCredential = await _auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );

    // TODO: Step 2: Update displayName in FirebaseAuth
    // await userCredential.user?.updateDisplayName('$firstName $lastName');

    // TODO: Step 3: Create user document in Firestore 'users' collection
    // final userModel = UserModel(
    //   uid: userCredential.user!.uid,
    //   email: email,
    //   displayName: '$firstName $lastName',
    //   firstName: firstName,
    //   lastName: lastName,
    //   phoneNumber: phoneNumber,
    //   bio: bio,
    //   address: address,
    //   createdAt: DateTime.now(),
    // );
    // await _firestore.collection('users').doc(userCredential.user!.uid).set(userModel.toMap());

    // TODO: Step 4: Return UserModel
    throw UnimplementedError('Students need to implement signUp()');
  }

  /// Sign in existing user
  ///
  /// TODO: Students will implement this
  /// Steps:
  /// 1. Sign in with email/password using FirebaseAuth.signInWithEmailAndPassword()
  /// 2. Update lastLoginAt in Firestore 'users' collection
  /// 3. Fetch user data from Firestore
  /// 4. Return UserModel
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    // TODO: Step 1: Sign in with FirebaseAuth
    // final userCredential = await _auth.signInWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // );

    // TODO: Step 2: Update lastLoginAt in Firestore
    // await _firestore.collection('users').doc(userCredential.user!.uid).update({
    //   'lastLoginAt': FieldValue.serverTimestamp(),
    // });

    // TODO: Step 3: Fetch user data from Firestore
    // final userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
    // return UserModel.fromMap(userDoc.data()!);

    throw UnimplementedError('Students need to implement signIn()');
  }

  /// Sign out current user
  ///
  /// TODO: Students will implement this
  /// - Call FirebaseAuth.signOut()
  Future<void> signOut() async {
    // TODO: Sign out from FirebaseAuth
    // await _auth.signOut();
    throw UnimplementedError('Students need to implement signOut()');
  }

  /// Update user profile
  ///
  /// TODO: Students will implement this
  /// - Update user document in Firestore 'users' collection
  /// - Optionally update displayName in FirebaseAuth
  Future<void> updateProfile(UserModel user) async {
    // TODO: Update Firestore document
    // await _firestore.collection('users').doc(user.uid).update(user.toMap());

    // TODO: Optionally update FirebaseAuth displayName
    // await _auth.currentUser?.updateDisplayName(user.displayName);

    throw UnimplementedError('Students need to implement updateProfile()');
  }

  /// Send password reset email
  ///
  /// TODO: Students will implement this
  /// - Use FirebaseAuth.sendPasswordResetEmail()
  Future<void> sendPasswordResetEmail(String email) async {
    // TODO: Send password reset email
    // await _auth.sendPasswordResetEmail(email: email);
    throw UnimplementedError(
      'Students need to implement sendPasswordResetEmail()',
    );
  }
}
