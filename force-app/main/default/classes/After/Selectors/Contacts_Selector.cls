public with sharing class Contacts_Selector implements IContactSelector {
  public List<Contact> selectContactsByAccountIds(Set<Id> accountIds) {
    return [
      SELECT Id, AccountId, OtherPhone
      FROM Contact
      WHERE AccountId IN :accountIds
    ];
  }
}
