# 🌾 AgriEdge OMS — Smart Order Management System

> **A Salesforce-native Order Management System for AgriEdge Or-Mange Ltd** — featuring adaptive inventory thresholds, automated order processing, and real-time low-stock alerts.

---

## 📋 Table of Contents

- [About the Project](#about-the-project)
- [Problem Statement](#problem-statement)
- [Solution Architecture](#solution-architecture)
- [Key Features](#key-features)
- [Novelty — Adaptive Smart Threshold](#novelty--adaptive-smart-threshold)
- [Technology Stack](#technology-stack)
- [Custom Objects](#custom-objects)
- [Apex Trigger Logic](#apex-trigger-logic)
- [Salesforce Flows](#salesforce-flows)
- [Reports & Dashboards](#reports--dashboards)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Testing](#testing)
- [Authors](#authors)

---

## About the Project

AgriEdge OMS is a fully automated, cloud-based Order Management System built natively on the **Salesforce Platform**. It is designed for **AgriEdge Or-Mange Ltd**, a company operating in the **agriculture and food production** sector.

The system replaces manual, error-prone order processing with intelligent automation — from the moment an order is placed to the final delivery — while continuously learning from demand patterns to optimize inventory thresholds.

---

## Problem Statement

AgriEdge Or-Mange Ltd faces three critical operational challenges:

| # | Challenge | Impact |
|---|-----------|--------|
| 1 | **Manual Order Processing** | High error rates, slow turnaround, missed orders |
| 2 | **No Real-Time Inventory Visibility** | Stockouts, overstocking, lost revenue |
| 3 | **Disconnected Customer Service** | No unified view of order status, poor customer experience |

---

## Solution Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   SALESFORCE PLATFORM                    │
│                                                         │
│  ┌──────────┐   ┌──────────┐   ┌──────────────────┐    │
│  │ Customer │──▶│  Order   │──▶│     Product       │    │
│  │  Object  │   │  Object  │   │     Object        │    │
│  └──────────┘   └────┬─────┘   └────────┬─────────┘    │
│                      │                   │              │
│              ┌───────▼───────┐   ┌───────▼───────┐     │
│              │  Apex Trigger │   │  Scheduled     │     │
│              │  (Priority    │   │  Flow          │     │
│              │   Assignment) │   │  (Adaptive     │     │
│              └───────┬───────┘   │   Threshold)   │     │
│                      │           └───────┬───────┘     │
│              ┌───────▼───────┐           │             │
│              │ Record-       │   ┌───────▼───────┐     │
│              │ Triggered     │   │  Low Stock    │     │
│              │ Flow          │   │  Alert Flow   │     │
│              │ (Stock Update │   └───────────────┘     │
│              │  + Task)      │                         │
│              └───────────────┘                         │
│                                                         │
│  ┌─────────────────────────────────────────────────┐    │
│  │          Reports & Dashboards                    │    │
│  │  • Orders by Status  • Urgent Orders             │    │
│  │  • AgriEdge Operations Dashboard                 │    │
│  └─────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────┘
```

---

## Key Features

### 1. 🔄 Automated Order Processing
- Orders are created with fields: **Order ID, Customer, Product, Quantity, Status, Priority**
- **Apex Trigger** automatically assigns priority (High/Medium) based on stock levels and order quantity
- **Record-Triggered Flow** creates a processing task and reduces stock — all in real time

### 2. 📦 Real-Time Inventory Management
- Maintains live inventory records for each product
- Automatically **deducts stock** when an order is placed
- Triggers **Low Stock Alerts** when stock falls below threshold

### 3. 🧠 Adaptive Smart Threshold (Novelty)
- A **Scheduled Flow** runs daily to analyze order volume over the past 7 days
- **High Demand** (≥10 orders/week): Threshold increases by 10 units
- **Low Demand** (<3 orders/week): Threshold decreases by 5 units
- The system **learns and adapts** — no manual intervention required

### 4. 📊 Management Dashboard
- Visual reports grouped by **Order Status** and **Priority**
- Donut and Gauge charts for executive-level visibility
- Real-time data — no manual refresh needed

---

## Novelty — Adaptive Smart Threshold

> **This is the key differentiator of our system.**

Traditional inventory systems use **static thresholds** — a fixed number like "reorder when stock < 20." This fails in agriculture because demand is **seasonal and unpredictable**.

Our system implements a **dynamic, self-learning threshold** that adjusts based on actual order patterns:

```
┌──────────────────────────────────────────────┐
│          Adaptive Threshold Logic             │
│                                              │
│  Every Day at Midnight:                      │
│                                              │
│  FOR each Product:                           │
│    Count orders in last 7 days               │
│                                              │
│    IF orders ≥ 10  →  Threshold += 10        │
│       (High demand = need more buffer)       │
│                                              │
│    IF orders < 3   →  Threshold -= 5         │
│       (Low demand = reduce excess stock)     │
│                                              │
│    ELSE → No change                          │
│       (Normal demand = system is balanced)   │
└──────────────────────────────────────────────┘
```

**Why this matters for AgriEdge:**
- During **harvest season**, fertilizer demand spikes → the system automatically raises thresholds to prevent stockouts.
- During **off-season**, demand drops → the system lowers thresholds to reduce warehousing costs.

---

## Technology Stack

| Layer | Technology |
|-------|-----------|
| **Platform** | Salesforce (Developer Edition) |
| **Backend Logic** | Apex Triggers |
| **Automation** | Salesforce Flows (Record-Triggered + Scheduled) |
| **Data Model** | Custom Objects with Lookup Relationships |
| **Analytics** | Salesforce Reports & Dashboards |
| **Testing** | Apex Test Classes (≥75% code coverage) |

---

## Custom Objects

### Customer (`Customer__c`)
| Field | Type | Description |
|-------|------|-------------|
| Customer ID | Auto Number (`CUST-{0000}`) | Unique identifier |
| Name | Text | Customer name |
| Phone | Phone | Contact number |
| Email | Email | Contact email |
| Address | Text Area | Delivery address |

### Product (`Product__c`)
| Field | Type | Description |
|-------|------|-------------|
| Product Name | Text | Name of the product |
| Stock Quantity | Number | Current stock level |
| Threshold | Number | Minimum stock level before alert |

### Order (`Order__c`)
| Field | Type | Description |
|-------|------|-------------|
| Order ID | Auto Number (`ORD-{0000}`) | Unique identifier |
| Customer | Lookup (Customer) | Related customer |
| Product | Lookup (Product) | Related product |
| Quantity | Number | Units ordered |
| Status | Picklist | Pending / Processing / Shipped / Delivered |
| Priority | Picklist | High / Medium (auto-assigned by Trigger) |
| Order Date | Date | Date order was placed |

---

## Apex Trigger Logic

The `NewOrderTrigger` fires **before insert** on the Order object and implements the adaptive priority assignment:

```apex
// Pseudocode
FOR each new Order:
    GET the related Product's Stock and Threshold
    
    IF (Stock < Threshold) OR (Order Quantity > 50):
        SET Priority = "High"    // Urgent processing needed
    ELSE:
        SET Priority = "Medium"  // Standard processing
```

**Why `before insert`?** — The priority is set before the record is saved to the database, ensuring it's immediately visible to all users without a second database operation.

---

## Salesforce Flows

| # | Flow Name | Type | Purpose |
|---|-----------|------|---------|
| 1 | **Order Creation Automation** | Record-Triggered | Reduces stock + creates processing task on every new order |
| 2 | **Low Stock Alert** | Record-Triggered | Creates alert task when stock falls below threshold |
| 3 | **Adaptive Threshold Logic** | Scheduled (Daily) | Analyzes 7-day demand and adjusts thresholds automatically |

---

## Reports & Dashboards

| Report | Description |
|--------|-------------|
| **Orders by Status** | Grouped view of all orders by their current status |
| **Urgent High Priority Orders** | Filtered list of only high-priority orders |
| **AgriEdge Operations Dashboard** | Executive dashboard with donut and gauge charts |

---

## Project Structure

```
AgriEdge-OMS-Project/
├── README.md                          # This file
├── salesforce_setup_guide.md          # Step-by-step Salesforce configuration guide
└── force-app/
    └── main/
        └── default/
            ├── triggers/
            │   └── OrderTrigger.trigger    # Apex Trigger for priority assignment
            └── classes/
                └── OrderTriggerTest.cls    # Apex Test Class (3 test methods)
```

---

## Setup Instructions

1. **Log in** to your Salesforce Developer Org
2. **Create Custom Objects**: Customer, Product, Order (see `salesforce_setup_guide.md`)
3. **Deploy Apex Trigger**: Copy `NewOrderTrigger` code into Developer Console
4. **Build Flows**: Follow the guide to create all 3 automation flows
5. **Create Reports & Dashboard**: Build the management analytics layer
6. **Test**: Create sample products, customers, and orders to verify automation

> 📖 For detailed, step-by-step instructions, see [`salesforce_setup_guide.md`](salesforce_setup_guide.md)

---

## Testing

The project includes an Apex Test Class (`OrderTriggerTest.cls`) with **3 test methods** covering:

| Test Method | Scenario | Expected Result |
|-------------|----------|-----------------|
| `testHighPriorityDueToLowStock` | Product stock is below threshold | Priority = High |
| `testHighPriorityDueToHighQuantity` | Order quantity > 50 | Priority = High |
| `testMediumPriorityNormalConditions` | Normal stock, normal quantity | Priority = Medium |

---

## Authors

**AgriEdge Or-Mange Ltd** — Agriculture & Food Production Sector

---

> *Built with ❤️ on the Salesforce Platform*
