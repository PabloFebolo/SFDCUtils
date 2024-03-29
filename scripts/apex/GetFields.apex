Type t = Type.forName('PermissionSet');
SObject objInst = (SObject) t.newInstance();
Map<String, Schema.SObjectField> objFieldMap = objInst.getSObjectType().getDescribe().fields.getMap();
system.debug(LoggingLevel.DEBUG,'SIZE =' + objFieldMap.size());
for (string fieldname : objFieldMap.keySet())
	system.debug(LoggingLevel.DEBUG,'FIELD = ' + fieldname);
