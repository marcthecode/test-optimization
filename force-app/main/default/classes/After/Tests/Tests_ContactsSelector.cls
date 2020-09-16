@IsTest
public class Tests_ContactsSelector implements IContactSelector {
  private List<Contact> selectContactsByAccountIdsResult;
  public void configureSelectContactsByAccountIds(
    List<Contact> expectedResults
  ) {
    this.selectContactsByAccountIdsResult = expectedResults;
  }

  public List<Contact> selectContactsByAccountIds(Set<Id> accountIds) {
    return this.selectContactsByAccountIdsResult;
  }
}
