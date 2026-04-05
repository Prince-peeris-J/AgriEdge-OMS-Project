@isTest
public class OrderTriggerTest {
    
    @testSetup
    static void setupTestData() {
        // Create Sample Customer
        Customer__c cust = new Customer__c(
            Name = 'Test Customer',
            Phone__c = '1234567890',
            Email__c = 'test@example.com',
            Address__c = '123 Agri St'
        );
        insert cust;

        // Create Sample Products
        List<Product__c> products = new List<Product__c>();
        
        // Product 1: High Stock (Stock > Threshold)
        products.add(new Product__c(
            Product_Name__c = 'Fertilizer A',
            Stock_Quantity__c = 100,
            Threshold_Level__c = 20
        ));
        
        // Product 2: Low Stock (Stock < Threshold)
        products.add(new Product__c(
            Product_Name__c = 'Tractor Part B',
            Stock_Quantity__c = 5,
            Threshold_Level__c = 10
        ));

        insert products;
    }
    
    @isTest
    static void testHighPriorityDueToLowStock() {
        Product__c lowStockProd = [SELECT Id FROM Product__c WHERE Product_Name__c = 'Tractor Part B' LIMIT 1];
        Customer__c cust = [SELECT Id FROM Customer__c LIMIT 1];
        
        Order__c ord = new Order__c(
            Customer__c = cust.Id,
            Product__c = lowStockProd.Id,
            Quantity__c = 2,
            Status__c = 'Pending'
        );
        
        Test.startTest();
        insert ord;
        Test.stopTest();
        
        Order__c insertedOrder = [SELECT Priority__c FROM Order__c WHERE Id = :ord.Id];
        System.assertEquals('High', insertedOrder.Priority__c, 'Priority should be High due to low stock');
    }
    
    @isTest
    static void testHighPriorityDueToHighQuantity() {
        Product__c highStockProd = [SELECT Id FROM Product__c WHERE Product_Name__c = 'Fertilizer A' LIMIT 1];
        Customer__c cust = [SELECT Id FROM Customer__c LIMIT 1];
        
        Order__c ord = new Order__c(
            Customer__c = cust.Id,
            Product__c = highStockProd.Id,
            Quantity__c = 60, // Greater than 50
            Status__c = 'Pending'
        );
        
        Test.startTest();
        insert ord;
        Test.stopTest();
        
        Order__c insertedOrder = [SELECT Priority__c FROM Order__c WHERE Id = :ord.Id];
        System.assertEquals('High', insertedOrder.Priority__c, 'Priority should be High due to high quantity (>50)');
    }
    
    @isTest
    static void testMediumPriorityNormalConditions() {
        Product__c highStockProd = [SELECT Id FROM Product__c WHERE Product_Name__c = 'Fertilizer A' LIMIT 1];
        Customer__c cust = [SELECT Id FROM Customer__c LIMIT 1];
        
        Order__c ord = new Order__c(
            Customer__c = cust.Id,
            Product__c = highStockProd.Id,
            Quantity__c = 10, // Normal Quantity
            Status__c = 'Pending'
        );
        
        Test.startTest();
        insert ord;
        Test.stopTest();
        
        Order__c insertedOrder = [SELECT Priority__c FROM Order__c WHERE Id = :ord.Id];
        System.assertEquals('Medium', insertedOrder.Priority__c, 'Priority should be Medium for normal conditions');
    }
}
