# 🎤 Phase 7: Project Demonstration

## Demo Script — AgriEdge Smart Order Management System

> Use this script during your Viva to walk through the system confidently. Each section has talking points and the exact actions to perform in Salesforce.

---

## 🎯 Opening Statement (30 seconds)

> *"Good [morning/afternoon]. I am presenting the Smart Order Management System built for AgriEdge Or-Mange Ltd, a company operating in the agriculture and food production sector. The system is built natively on the Salesforce Platform and features an innovative Adaptive Smart Threshold that automatically adjusts inventory levels based on real-time demand patterns."*

---

## Demo Step 1: Show the Data Model (1 minute)

### Action:
1. Open **Setup** → **Object Manager**
2. Show the three custom objects: **Customer**, **Product**, **Order**
3. Click into **Order** and show the fields

### Talking Point:
> *"Our system has three core custom objects. The Order object is linked to both Customer and Product via lookup relationships. The Priority field is automatically assigned by our Apex Trigger — no manual input required."*

---

## Demo Step 2: Show the Apex Trigger (1 minute)

### Action:
1. Open the **Developer Console**
2. Navigate to the `NewOrderTrigger`
3. Briefly scroll through the code

### Talking Point:
> *"This is our Apex Trigger that fires before every new order is inserted. It queries the related product's stock level and threshold, then applies our adaptive priority logic: if stock is below the threshold OR the order quantity exceeds 50 units, the order is automatically flagged as High priority. This is bulk-safe and uses only one SOQL query to handle multiple orders efficiently."*

---

## Demo Step 3: Live Demo — Create an Order (2 minutes)

### Pre-requisite: Make sure you have a Product with LOW stock (e.g., Stock = 5, Threshold = 20)

### Action:
1. Go to the **Products** tab → Show the product with low stock
2. Go to the **Main Orders** tab → Click **New**
3. Select a Customer, select the low-stock Product, enter Quantity = 3
4. Click **Save**
5. **Show the Priority field** — it should say **"High"** ⭐

### Talking Point:
> *"Watch what happens when I create a new order for a product that is running low on stock. [Clicks Save] As you can see, the Priority field has been automatically set to 'High' because the Apex Trigger detected that the stock level is below the threshold. No human intervention was needed."*

---

## Demo Step 4: Show the Automated Stock Reduction (1 minute)

### Action:
1. Go back to the **Products** tab
2. Open the same product you ordered from
3. **Show that the Stock Quantity has decreased** by the order amount

### Talking Point:
> *"Notice that the stock quantity has automatically decreased from [X] to [X minus order quantity]. This was done by our Order Creation Automation flow — a record-triggered flow that fires immediately when an order is created. It also creates a processing task, which I'll show you next."*

---

## Demo Step 5: Show the Auto-Created Task (30 seconds)

### Action:
1. Click on the **Tasks** tab (or check the Activity section on the Order record)
2. Show the task: `"Process Order: ORD-XXXX"`

### Talking Point:
> *"Here is the processing task that was automatically created and assigned to the order owner. This ensures no order falls through the cracks — every single order gets a follow-up task."*

---

## Demo Step 6: Show the Low Stock Alert (1 minute)

### Action:
1. If the product's stock dropped below the threshold after your order, a **new Task** will appear
2. Show the task: `"LOW STOCK ALERT: [Product Name]"`

### Talking Point:
> *"Because the stock fell below the threshold after that order, our second flow — the Low Stock Alert — automatically fired and created this alert task. The warehouse manager now knows immediately that this product needs to be restocked."*

---

## Demo Step 7: Explain the Adaptive Threshold (Key Novelty!) (2 minutes)

### Action:
1. Go to **Setup** → **Flows** → Show the **Adaptive Threshold Logic** flow
2. Walk through the flow visually: Get Records → Count → Decision → Update

### Talking Point:
> *"This is the most innovative feature of our system — the Adaptive Smart Threshold. Unlike traditional inventory systems that use a fixed reorder point, our system learns from actual order patterns.*
>
> *Every day at midnight, this scheduled flow runs automatically. For each product, it counts how many orders were placed in the last 7 days. If a product received 10 or more orders — indicating high demand — the threshold increases by 10 units. This means the system will trigger alerts earlier, preventing stockouts during peak seasons.*
>
> *Conversely, if a product received fewer than 3 orders, the threshold decreases by 5 units, reducing unnecessary alerts and warehousing costs during off-peak periods.*
>
> *This is particularly relevant for AgriEdge because agricultural demand is highly seasonal — fertilizer demand spikes during planting season and drops during harvesting. Our system adapts automatically without any manual intervention."*

---

## Demo Step 8: Show the Dashboard (1 minute)

### Action:
1. Go to the **Dashboards** tab
2. Open the **AgriEdge Operations Dashboard**
3. Show the Donut Chart (Orders by Status) and Gauge Chart (Urgent Orders)

### Talking Point:
> *"Finally, here is our executive dashboard that gives managers a real-time overview of all operations. The donut chart shows the distribution of orders across different statuses, while the gauge shows how many high-priority orders need immediate attention. This dashboard refreshes automatically with live data."*

---

## 🎯 Closing Statement (30 seconds)

> *"In summary, the AgriEdge Smart OMS transforms a manual, error-prone process into a fully automated, intelligent system. The Adaptive Smart Threshold is our key innovation — it makes the system self-learning, eliminating the need for manual threshold adjustments. The entire solution was built using Salesforce's native capabilities: Custom Objects for data, Apex for business logic, Flows for automation, and Reports & Dashboards for analytics. Thank you."*

---

## ❓ Anticipated Viva Questions & Answers

### Q1: Why did you choose Salesforce over a custom web application?
> *"Salesforce provides built-in CRM capabilities, enterprise-grade security, and declarative automation tools (Flows) that would take months to build from scratch. It also provides native reporting and dashboards without additional coding."*

### Q2: What is the advantage of your Adaptive Threshold over a static threshold?
> *"A static threshold fails in agriculture because demand is seasonal. During monsoon season, fertilizer orders spike — a static threshold of 20 would cause stockouts. Our adaptive system automatically raises the threshold to 30 or 40 based on actual demand, preventing stockouts. During off-season, it reduces back down to save storage costs."*

### Q3: How does your Apex Trigger handle bulk operations?
> *"The trigger is bulk-safe. It collects all Product IDs first, then makes a single SOQL query to fetch all relevant products into a Map. This avoids the N+1 query problem and respects Salesforce governor limits."*

### Q4: What happens if the Product field is empty on an order?
> *"The trigger checks for null values. If no product is attached, it defaults the Priority to 'Medium' instead of throwing an error."*

### Q5: How do you ensure code quality?
> *"We have an Apex Test Class with 3 test methods covering all scenarios: low stock, high quantity, and normal conditions. This gives us 100% code coverage, well above Salesforce's required 75%."*

### Q6: What are the future enhancements you would add?
> *"Three key enhancements: (1) Email notifications using Salesforce Email Alerts, (2) A customer-facing portal using Experience Cloud, and (3) Einstein Analytics for AI-powered demand forecasting."*

### Q7: Explain the difference between a Record-Triggered Flow and a Schedule-Triggered Flow.
> *"A Record-Triggered Flow fires automatically when a record is created, updated, or deleted — like our Order Creation Automation. A Schedule-Triggered Flow runs at a set time — like our Adaptive Threshold that runs daily at midnight. Both are declarative tools that don't require code."*

### Q8: What is the role of the `before insert` context in your trigger?
> *"The `before insert` context allows us to modify the record before it is saved to the database. This means we can set the Priority field without performing an additional DML (update) operation, which is more efficient and avoids hitting governor limits."*
