import 'invitations_DAO.dart';

class Invitation {
  String projectName = '';
  String ownerID = '';
  String userID = '';

  Invitation(String projectName, String ownerID, String userID){
    this.projectName = projectName;
    this.ownerID = ownerID;
    this.userID = userID;
  }
}

class Invitations_BO{
  final Invitations_DAO _invitationsDAO = Invitations_DAO();

  // Get number of Invitations
  Future<String> getNumInvitations() async {
    String numInvites = await _invitationsDAO.numInvitations();
    return numInvites;
  }

  // Get the invitations aimed towards the current user
  Future<List<Invitation>> getUserInvitations() async {
    List<Invitation> invites = await _invitationsDAO.getUserInbox();
    return invites;
  }

   // If the user accepts the invite, add them to as a member to the project
  Future<void> acceptInvite(String pName, String oID) async {
    await _invitationsDAO.insertOwner(pName, oID);
  }

  // Remove invitatiosn from inbox once it gets accepted or declined
  Future<void> removeInvitation(String pName, String oID) async {
    await _invitationsDAO.deleteInvitation(pName, oID);
  }
}