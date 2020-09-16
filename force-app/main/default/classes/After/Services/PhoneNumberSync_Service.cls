public with sharing class PhoneNumberSync_Service {
  private IContactSelector contactSelector;
  public PhoneNumberSync_Service() {
    this(new Contacts_Selector());
  }

  @TestVisible
  private PhoneNumberSync_Service(IContactSelector contactSelector) {
    this.contactSelector = contactSelector;
  }

  public List<Contact> SyncPhoneNumbers(Map<Id, Account> accountMap) {
    List<Contact> relatedContacts = this.contactSelector.selectContactsByAccountIds(
      accountMap.keySet()
    );

    List<Contact> contactsToUpdate = new List<Contact>();

    for (Account currentAccount : accountMap.values()) {
      // We don't want to propagate null numbers to our contacts.
      if (currentAccount.Phone == null) {
        break;
      }
      // This is a special phone number that we want to ignore.
      if (currentAccount.Phone == '202-555-0199') {
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

    return contactsToUpdate;
  }
}
