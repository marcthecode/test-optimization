@IsTest
public class OptimizedAccountHandler_Tests {
  @IsTest
  public static void GivenAnAccount_WhenPhoneNumberIsUpdated_ThenContactsNumberAreUpdated() {
    // Arrange
    Account testAccount = new Account(
      Name = 'Test Account',
      Phone = '202-555-0162'
    );
    Test_Utils.setId(testAccount);

    Contact testContact = new Contact(AccountId = testAccount.Id);
    Test_Utils.setId(testContact);

    // Act
    Tests_ContactsSelector testContactSelector = new Tests_ContactsSelector();
    testContactSelector.configureSelectContactsByAccountIds(
      new List<Contact>{ testContact }
    );

    Map<Id, Account> accountMap = new Map<Id, Account>();
    accountMap.put(testAccount.Id, testAccount);

    PhoneNumberSync_Service service = new PhoneNumberSync_Service(
      testContactSelector
    );
    List<Contact> contactsToUpdate = service.SyncPhoneNumbers(accountMap);

    // Assert
    system.assertEquals(testAccount.Phone, contactsToUpdate[0].OtherPhone);
  }

  @IsTest
  public static void GivenAnAccount_WhenPhoneNumberIsNull_ThenContactsNumberAreNotUpdated() {
    // Arrange
    Account testAccount = new Account(
      Name = 'Test Account'
    );
    Test_Utils.setId(testAccount);

    Contact testContact = new Contact(AccountId = testAccount.Id, OtherPhone = '202-555-0162');
    Test_Utils.setId(testContact);

    // Act
    Tests_ContactsSelector testContactSelector = new Tests_ContactsSelector();
    testContactSelector.configureSelectContactsByAccountIds(
      new List<Contact>{ testContact }
    );

    Map<Id, Account> accountMap = new Map<Id, Account>();
    accountMap.put(testAccount.Id, testAccount);

    PhoneNumberSync_Service service = new PhoneNumberSync_Service(
      testContactSelector
    );
    List<Contact> contactsToUpdate = service.SyncPhoneNumbers(accountMap);

    // Assert
    system.assertEquals(0, contactsToUpdate.size());
  }

  @IsTest
  public static void GivenAnAccount_WhenPhoneNumberIsSpecial_ThenContactsNumberAreNotUpdated() {
    // Arrange
    Account testAccount = new Account(
      Name = 'Test Account',
      Phone = '202-555-0199'
    );
    Test_Utils.setId(testAccount);

    Contact testContact = new Contact(AccountId = testAccount.Id, OtherPhone = '202-555-0132');
    Test_Utils.setId(testContact);

    // Act
    Tests_ContactsSelector testContactSelector = new Tests_ContactsSelector();
    testContactSelector.configureSelectContactsByAccountIds(
      new List<Contact>{ testContact }
    );

    Map<Id, Account> accountMap = new Map<Id, Account>();
    accountMap.put(testAccount.Id, testAccount);

    PhoneNumberSync_Service service = new PhoneNumberSync_Service(
      testContactSelector
    );
    List<Contact> contactsToUpdate = service.SyncPhoneNumbers(accountMap);

    // Assert
    system.assertEquals(0, contactsToUpdate.size());
  }
}
