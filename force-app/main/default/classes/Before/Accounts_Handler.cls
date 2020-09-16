public with sharing class Accounts_Handler extends TriggerHandler {
  private Map<Id, Account> newAccountsMap;

  public Accounts_Handler() {
    this.newAccountsMap = (Map<Id, Account>) Trigger.NewMap;
  }

  public override void afterUpdate() {
    // When updating the account phone number, we want to also update all of its contacts phone number.
    Set<Id> accountIds = newAccountsMap.keySet();
    List<Contact> relatedContacts = [
      SELECT Id, AccountId, OtherPhone
      FROM Contact
      WHERE AccountId IN :accountIds
    ];

    List<Contact> contactsToUpdate = new List<Contact>();
    for (Account currentAccount : this.newAccountsMap.values()) {
      // We don't want to propagate null numbers to our contacts.
      if (currentAccount.Phone == null) {
        break;
      }
      // This is a special phone number that we want to ignore.
      if(currentAccount.Phone == '202-555-0199'){
        break;
      }
      // For all other scenarios, we want to perform the update.
      for (Contact currentContact : relatedContacts) {
        if (currentContact.AccountId == currentAccount.Id) {
          currentContact.OtherPhone = currentAccount.Phone;

          contactsToUpdate.add(currentContact);
        }
      }

    }

    update contactsToUpdate;
  }
}
