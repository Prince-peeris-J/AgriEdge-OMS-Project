# 💻 Phase 5: Project Development

## 5.1 Development Environment

| Component | Details |
|-----------|---------|
| **Platform** | Salesforce Developer Edition |
| **Org URL** | `chennaiinstituteoftechn137-dev-ed.develop.my.salesforce.com` |
| **IDE** | Salesforce Developer Console |
| **API Version** | 66.0 |
| **Deployment Status** | Deployed |

---

## 5.2 Custom Object Implementation

### Object 1: Customer (`Customer__c`)

**Purpose:** Stores information about AgriEdge's business customers.

| Field Label | API Name | Data Type | Description |
|-------------|----------|-----------|-------------|
| Customer ID | Name (Auto Number) | Auto Number `CUST-{0000}` | Unique identifier |
| Name | Name | Text(80) | Customer company name |
| Phone | Phone__c | Phone | Contact number |
| Email | Email__c | Email | Contact email |
| Address | Address__c | Text Area | Delivery address |

### Object 2: Product (`Product__c`)

**Purpose:** Maintains inventory catalog with stock levels and adaptive thresholds.

| Field Label | API Name | Data Type | Description |
|-------------|----------|-----------|-------------|
| Product Name | Name | Text(80) | Product identifier |
| Stock Quantity | Stock_Quantity__c | Number(18,0) | Current stock level |
| Threshold | Threshold__c | Number(18,0) | Dynamic reorder point |
| Last Updated | Last_Updated__c | Date | Tracks last stock change |

### Object 3: Order (`Order__c`)

**Purpose:** Core transaction record linking customers to products.

| Field Label | API Name | Data Type | Description |
|-------------|----------|-----------|-------------|
| Order ID | Name (Auto Number) | Auto Number `ORD-{0000}` | Unique identifier |
| Customer | Customer__c | Lookup(Customer) | Related customer |
| Product | Product__c | Lookup(Product) | Related product |
| Quantity | Quantity__c | Number | Units ordered |
| Status | Status__c | Picklist | Pending / Processing / Shipped / Delivered |
| Priority | Priority__c | Picklist | High / Medium (auto-set by trigger) |
| Order Date | Order_Date__c | Date | Date of order creation |

---

## 5.3 Apex Trigger: Adaptive Priority Assignment

### File: `NewOrderTrigger.trigger`

**Purpose:** Automatically assigns order priority based on real-time inventory data and order volume.

**Trigger Event:** `before insert` on `Order__c`

**Logic:**

```apex
trigger NewOrderTrigger on Order__c (before insert) {
    // Step 1: Collect all Product IDs from incoming orders
    Set<Id> productIds = new Set<Id>();
    for(Order__c o : Trigger.new){
        if (o.Product__c != null) {
            productIds.add(o.Product__c);
        }
    }
    
    // Step 2: Query Product stock and threshold in one SOQL call
    Map<Id, Product__c> productMap = new Map<Id, Product__c>();
    if (!productIds.isEmpty()) {
        productMap = new Map<Id, Product__c>([
            SELECT Id, Stock_Quantity__c, Threshold__c 
            FROM Product__c 
            WHERE Id IN :productIds
        ]);
    }
    
    // Step 3: Apply adaptive priority logic
    for(Order__c o : Trigger.new){
        if (o.Product__c != null && productMap.containsKey(o.Product__c)) {
            Product__c p = productMap.get(o.Product__c);
            
            // HIGH priority if stock is critically low OR bulk order (>50 units)
            if(p.Stock_Quantity__c < p.Threshold__c || o.Quantity__c > 50){
                o.Priority__c = 'High';
            } else {
                o.Priority__c = 'Medium';
            }
        } else {
            o.Priority__c = 'Medium';
        }
    }
}
```

**Key Design Decisions:**
- **Bulk-safe:** Uses `Set<Id>` and `Map` to handle multiple orders in a single transaction
- **Single SOQL query:** Avoids governor limit issues by querying all products at once
- **`before insert`:** Sets priority before the record is saved, avoiding an extra DML operation

---

## 5.4 Apex Test Class

### File: `OrderTriggerTest.cls`

**Purpose:** Validates trigger logic across 3 scenarios to ensure ≥75% code coverage.

| # | Test Method | Scenario | Expected Output |
|---|-------------|----------|-----------------|
| 1 | `testHighPriorityDueToLowStock()` | Product stock (5) < threshold (10) | Priority = "High" |
| 2 | `testHighPriorityDueToHighQuantity()` | Order quantity (60) > 50 | Priority = "High" |
| 3 | `testMediumPriorityNormalConditions()` | Stock (100) > threshold (20), quantity (10) < 50 | Priority = "Medium" |

**Test Data Strategy:** Uses `@testSetup` to create shared test data (1 Customer, 2 Products) across all test methods for efficiency.

---

## 5.5 Salesforce Flow Development

### Flow 1: Order Creation Automation
| Property | Value |
|----------|-------|
| **Type** | Record-Triggered Flow |
| **Object** | Order__c |
| **Trigger** | A record is created |
| **Elements** | Get Records → Update Records → Create Records |

**What it does:**
1. Fetches the related Product record
2. Subtracts the order quantity from the product's stock using a formula: `Stock - Order Quantity`
3. Creates a Task assigned to the current user: `"Process Order: ORD-XXXX"`

### Flow 2: Low Stock Alert
| Property | Value |
|----------|-------|
| **Type** | Record-Triggered Flow |
| **Object** | Product__c |
| **Trigger** | A record is updated |
| **Elements** | Decision → Create Records |

**What it does:**
1. Checks if the updated stock quantity is less than the threshold
2. If yes, creates an alert Task: `"LOW STOCK ALERT: [Product Name]"`
3. Only fires when the record *first* meets the low-stock condition

### Flow 3: Adaptive Threshold Logic (Novelty)
| Property | Value |
|----------|-------|
| **Type** | Schedule-Triggered Flow |
| **Schedule** | Daily at 12:00 AM |
| **Object** | Product__c (all records) |
| **Elements** | Get Records → Assignment → Decision → Update Records (x2) |

**What it does:**
1. For each product, counts orders placed in the last 7 days
2. If order count ≥ 10 (High Demand): Increases threshold by 10
3. If order count < 3 (Low Demand): Decreases threshold by 5
4. Otherwise: No change (demand is normal)

---

## 5.6 Reports & Dashboards

### Report 1: Orders by Status
- **Type:** Summary Report
- **Grouping:** Status (Pending, Processing, Shipped, Delivered)
- **Chart:** Donut Chart

### Report 2: Urgent High Priority Orders
- **Type:** Tabular Report
- **Filter:** Priority = "High"
- **Purpose:** Quick view of orders needing immediate attention

### Dashboard: AgriEdge Operations Dashboard
- **Component 1:** Orders by Status (Donut Chart)
- **Component 2:** Urgent Orders (Gauge Chart)
- **Refresh:** Real-time data from underlying reports

---

## 5.7 Challenges Faced & Solutions

| # | Challenge | Solution |
|---|-----------|----------|
| 1 | `Threshold_Level__c` field name mismatch in Apex | Verified field API names in Object Manager; corrected to `Threshold__c` |
| 2 | Custom objects not appearing in App Launcher | Created Custom Object Tabs via Setup → Tabs |
| 3 | Flow Start element couldn't compare two fields | Used Decision element after the Start to compare fields |
| 4 | "Check for Matching Records" causing errors in Flow | Disabled the matching toggle on Create Records elements |
| 5 | Standard Product object appearing instead of custom | Navigated via custom tab instead of App Launcher search |
