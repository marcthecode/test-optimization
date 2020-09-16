public with sharing class OptimizedAccount_Handler extends TriggerHandler {
  private Map<Id, Account> newAccountsMap;

  public OptimizedAccount_Handler() {
    this.newAccountsMap = (Map<Id, Account>) Trigger.NewMap;
  }

  public override void afterUpdate() {
    PhoneNumberSync_Service phoneNumberService = new PhoneNumberSync_Service();
    List<Contact> contactsToUpdate = phoneNumberService.SyncPhoneNumbers(this.newAccountsMap);
    update contactsToUpdate;
  }
}
