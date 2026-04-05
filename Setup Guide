# AgriEdge Order Management System (OMS) - Salesforce Setup Guide

This guide provides the exact steps to build your AgriEdge OMS directly within the Salesforce UI. Follow these instructions carefully to ensure your final project demo works perfectly.

## 1. Data Layer: Creating Custom Objects
You need to create 3 Custom Objects. Go to **Setup -> Object Manager -> Create Custom Object**.

### A. Customer (`Customer__c`)
- **Label**: Customer
- **Plural Label**: Customers
- **Record Name**: Customer ID (Data Type: Auto Number, Display Format: `CUST-{0000}`)
**Custom Fields to Create:**
1. **Name**: Text (80)
2. **Phone**: Phone
3. **Email**: Email
4. **Address**: Text Area (255)

### B. Product (`Product__c`)
- **Label**: Product
- **Plural Label**: Products
- **Record Name**: Product ID (Data Type: Auto Number, Display Format: `PROD-{0000}`)
**Custom Fields to Create:**
1. **Product Name**: Text (80)
2. **Stock Quantity**: Number (18, 0)
3. **Threshold Level**: Number (18, 0)
4. **Last Updated**: Date

### C. Order (`Order__c`)
- **Label**: Main Order
- **Plural Label**: Main Orders
- **Record Name**: Order ID (Data Type: Auto Number, Display Format: `ORD-{0000}`)
**Custom Fields to Create:**
1. **Customer**: Lookup Relationship -> Customer Object
2. **Product**: Lookup Relationship -> Product Object
3. **Quantity**: Number (18, 0)
4. **Status**: Picklist (Values: `Pending`, `Processing`, `Shipped`, `Delivered`) - Set `Pending` as Default.
5. **Priority**: Picklist (Values: `Low`, `Medium`, `High`)
6. **Order Date**: Date

---

## 2. Logic Layer Part 1: Apex Trigger
The Apex code automatically handles assigning priority based on product stock and order size. 
1. Open **Developer Console** (Gear icon top right -> Developer Console).
2. Go to **File -> New -> Apex Trigger**.
3. Name it `OrderTrigger` and choose `Main Order` (`Order__c`) as the sObject.
4. Copy and paste the code from the generated file: `force-app/main/default/triggers/OrderTrigger.trigger`
5. Save the file (`Ctrl+S`).

*(Optional)* Create the test class: **File -> New -> Apex Class**, name it `OrderTriggerTest`, and paste the code from `force-app/main/default/classes/OrderTriggerTest.cls`. Click **Test -> Run All** to verify.

---

## 3. Logic Layer Part 2: Salesforce Flows
Go to **Setup -> Flows -> New Flow**.

### Flow 1: Order Creation Automation
*Automatically updates stock and generates a task.*
1. **Type**: Record-Triggered Flow.
2. **Object**: `Order__c`.
3. **Trigger**: *A record is created*.
4. **Step 1 (Get Record)**: Get `Product__c` where Id equals `{!$Record.Product__c}`.
5. **Step 2 (Assignment)**: Reduce product stock.
    - Variable: `{!Get_Product.Stock_Quantity__c}`
    - Operator: `Subtract`
    - Value: `{!$Record.Quantity__c}`
6. **Step 3 (Update Record)**: Update the `Product__c` record with the new stock value.
7. **Step 4 (Create Record)**: Create a `Task`.
    - Subject: "Process Order: " + `{!$Record.Name}`
    - OwnerId: `{!$User.Id}`
    - WhatId: `{!$Record.Id}`

### Flow 2: Low Stock Alert
*Alerts when stock drops.*
1. **Type**: Record-Triggered Flow.
2. **Object**: `Product__c`.
3. **Trigger**: *A record is updated*.
4. **Condition**: `Stock_Quantity__c` < (Less Than) `Threshold_Level__c`.
5. **Action**: Select **Send Custom Notification**. Include the Product Name in the notification body. *(Note: You need to create a Custom Notification Type in Setup first).*

### Flow 3: Adaptive Threshold Logic (Novelty Feature)
*Drives the adaptive behavior of the OMS.*
1. **Type**: Schedule-Triggered Flow (Runs Nightly).
2. **Object**: `Product__c`. 
3. **Step 1 (Get Records)**: Get all `Order__c` where Product = `{!$Record.Id}` AND CreatedDate >= Last 7 Days. Store in a Collection Variable.
4. **Step 2 (Assignment)**: Assign the Count of the collection to a number variable `Order_Count`.
5. **Step 3 (Decision)**:
    - **Outcome 1 (Demand Rising)**: If `Order_Count` > 10.
        - **Update Record**: Set `Product__c.Threshold_Level__c` to `{!$Record.Threshold_Level__c} + 10`.
    - **Outcome 2 (Demand Dropping)**: If `Order_Count` < 3.
        - **Update Record**: Set `Product__c.Threshold_Level__c` to `{!$Record.Threshold_Level__c} - 5`.

### Flow 4: Order Delay Escalation
*Automatically flags delayed orders.*
1. **Type**: Schedule-Triggered Flow (Runs Daily).
2. **Object**: `Order__c`.
3. **Condition**: `Status__c` = 'Pending' AND `CreatedDate` < (Less Than) `{!$Flow.CurrentDate} - 2`.
4. **Step 1 (Update Record)**: Update the triggering `Order__c`.
    - Field `Priority__c` = 'High'.
5. **Step 2 (Create Record)**: Create an Escalation `Task` attached to the Order.

---

## 4. Presentation Layer: Reports & Dashboards
Go to the **Reports** tab in your Sales app.
*(Ensure your Objects have "Allow Reports" checked in Object Manager).*

1. **New Report -> "Orders with Products"**
    - Group by: `Status__c`.
    - Add to Dashboard as a **Pie Chart**.
2. **New Report -> "Low Stock Alerts"**
    - Filter: `Stock_Quantity__c` < Field `Threshold_Level__c` (*Note: Use Field-to-Field filters in Lightning Builder*).
    - Add to Dashboard as a **Detail Table**.
3. **New Report -> "Delayed High Priority Orders"**
    - Filter: `Priority__c` = 'High' AND `Status__c` = 'Pending'.
    - Add to Dashboard as a **Metric Component**.

## 5. Security (For your Viva Defense)
To demonstrate Security:
1. Go to **Setup -> Profiles**.
2. Clone the Standard User profile, call it `OMS Staff Profile`.
3. Under **Custom Object Permissions**, uncheck "Delete" for Orders, Products, and Customers.
4. Mention this in your presentation: *"By utilizing Role-Based Access Control, we've simulated real-world governance where Staff can manage but not delete core operational records."*
