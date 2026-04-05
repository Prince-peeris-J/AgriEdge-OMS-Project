trigger OrderTrigger on Order__c (before insert) {
    // Collect all Product IDs related to the incoming orders
    Set<Id> productIds = new Set<Id>();
    for(Order__c o : Trigger.new){
        if (o.Product__c != null) {
            productIds.add(o.Product__c);
        }
    }
    
    // Query Product details to check Stock vs Threshold
    Map<Id, Product__c> productMap = new Map<Id, Product__c>();
    if (!productIds.isEmpty()) {
        productMap = new Map<Id, Product__c>([
            SELECT Id, Stock_Quantity__c, Threshold_Level__c 
            FROM Product__c 
            WHERE Id IN :productIds
        ]);
    }
    
    // Assign Priority based on Adaptive Logic
    for(Order__c o : Trigger.new){
        if (o.Product__c != null && productMap.containsKey(o.Product__c)) {
            Product__c p = productMap.get(o.Product__c);
            
            // Logic: High priority if stock is low OR order quantity is high (> 50)
            if(p.Stock_Quantity__c < p.Threshold_Level__c || o.Quantity__c > 50){
                o.Priority__c = 'High';
            } else {
                o.Priority__c = 'Medium';
            }
        } else {
            // Default priority if no product attached
            o.Priority__c = 'Medium';
        }
    }
}
