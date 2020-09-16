public with sharing class Test_Utils {
    private static Integer count = 0;
	private static final String pattern = '000000000000';

	public static void setId(SObject currentObject)
	{
		String keyPrefix = currentObject.getSObjectType().getDescribe().getKeyPrefix();
		count++;
		String idPrefix = pattern.substring(0, 12 - String.valueOf(count).length());
		currentObject.Id = Id.valueOf(keyPrefix + idPrefix + count);
	}
}
