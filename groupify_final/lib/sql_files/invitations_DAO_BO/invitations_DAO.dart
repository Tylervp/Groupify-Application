import '/auth/firebase_auth/auth_util.dart';
import 'package:groupify_final/sql_database_connection.dart';
import 'package:groupify_final/sql_files/invitations_DAO_BO/invitations_BO.dart';

class Invitations_DAO{
  // Initialize database connectiong helper
  final SQLDatabaseHelper _sqldatabaseHelper = SQLDatabaseHelper();

  // Get number of Invitations
  Future<String> numInvitations() async {
    await _sqldatabaseHelper.connectToDatabase();
    final results = await _sqldatabaseHelper.connection.query('SELECT * FROM Inbox WHERE userID = ?', [currentUserDisplayName]);
    await _sqldatabaseHelper.closeConnection();
    return results.length.toString();
  }

  // Get Invitations meant for the current user
  Future<List<Invitation>> getUserInbox() async {
    await _sqldatabaseHelper.connectToDatabase();
    List<Invitation> invitations = []; // List to hold instances of invitations
    final results = await _sqldatabaseHelper.connection.query('SELECT * FROM Inbox WHERE userID = ?', [currentUserDisplayName]);
    for(final row in results){
      String tempName = row['projectName'] as String;
      String tempOwnerID = row['ownerID'] as String;
      String tempUserID = row['userID'] as String;
      invitations.insert(0, Invitation(tempName, tempOwnerID, tempUserID)); // Insert invitations to the list
    }
    await _sqldatabaseHelper.closeConnection();
    return invitations;
  }

  // If the user accepts the invite, add them to the projectMembers table
  Future<void> insertOwner(String pName, String oID) async {
    await _sqldatabaseHelper.connectToDatabase();
    await _sqldatabaseHelper.connection.query('INSERT ProjectMembers (userID, projectName, ownerID) VALUES (?,?,?)',
                                  [currentUserDisplayName, pName, oID]);
    await _sqldatabaseHelper.closeConnection();
  }

  // Delete invitatiosn from inbox table after accepting or declining an invitation
  Future<void> deleteInvitation(String pName, String oID) async {
    await _sqldatabaseHelper.connectToDatabase();
    await _sqldatabaseHelper.connection.query('DELETE FROM Inbox WHERE userID = ? and projectName = ? and ownerID = ?',
                                  [currentUserDisplayName, pName, oID]);
    await _sqldatabaseHelper.closeConnection();
  }
}