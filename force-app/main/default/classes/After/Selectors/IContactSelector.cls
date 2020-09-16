public interface IContactSelector {
    List<Contact> selectContactsByAccountIds(Set<Id> accountIds);
}
