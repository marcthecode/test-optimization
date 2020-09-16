@IsTest
public class AccountsHandler_Tests {
  @IsTest
  public static void GivenAnAccount_WhenPhoneNumberIsUpdated_ThenContactsNumberAreUpdated() {
    // Arrange
    Account testAccount = new Account(Name = 'Test Account');
    insert testAccount;

    Contact testContact = new Contact(
      AccountId = testAccount.Id,
      Email = 'foo@example.com',
      LastName = 'Test'
    );
    insert testContact;

    // Act
    testAccount.Phone = '202-555-0162';
    update testAccount;

    // Assert
    Contact updatedContact = [
      SELECT Id, OtherPhone
      FROM Contact
      WHERE Id = :testContact.Id
    ];
    system.assertEquals(testAccount.Phone, updatedContact.OtherPhone);
  }

  @IsTest
  public static void GivenAnAccount_WhenPhoneNumberIsNull_ThenContactsNumberAreNotUpdated() {
    // Arrange
    Account testAccount = new Account(Name = 'Test Account', Phone = '202-555-0162');
    insert testAccount;

    Contact testContact = new Contact(
      AccountId = testAccount.Id,
      Email = 'foo@example.com',
      LastName = 'Test',
      OtherPhone = '202-555-0162'
    );
    insert testContact;

    // Act
    testAccount.Phone = null;
    update testAccount;

    // Assert
    Contact updatedContact = [
      SELECT Id, OtherPhone
      FROM Contact
      WHERE Id = :testContact.Id
    ];
    system.assertEquals(testContact.OtherPhone, updatedContact.OtherPhone);
  }

  @IsTest
  public static void GivenAnAccount_WhenPhoneNumberIsSpecial_ThenContactsNumberAreNotUpdated() {
    // Arrange
    Account testAccount = new Account(Name = 'Test Account');
    insert testAccount;

    Contact testContact = new Contact(
      AccountId = testAccount.Id,
      Email = 'foo@example.com',
      LastName = 'Test',
      OtherPhone = '202-555-0132'
    );
    insert testContact;

    // Act
    testAccount.Phone = '202-555-0199';
    update testAccount;

    // Assert
    Contact updatedContact = [
      SELECT Id, OtherPhone
      FROM Contact
      WHERE Id = :testContact.Id
    ];
    system.assertEquals(testContact.OtherPhone, updatedContact.OtherPhone);
  }
}