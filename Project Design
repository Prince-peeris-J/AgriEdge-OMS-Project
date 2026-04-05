# 🎨 Phase 3: Project Design

## 3.1 System Architecture

The AgriEdge OMS follows a **three-tier architecture** within the Salesforce Platform:

```
┌─────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐   │
│  │  Lightning    │  │  Reports &   │  │  App Launcher    │   │
│  │  Record Pages │  │  Dashboards  │  │  Navigation      │   │
│  └──────────────┘  └──────────────┘  └──────────────────┘   │
├─────────────────────────────────────────────────────────────┤
│                    BUSINESS LOGIC LAYER                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐   │
│  │  Apex        │  │  Record-     │  │  Scheduled       │   │
│  │  Triggers    │  │  Triggered   │  │  Flows           │   │
│  │              │  │  Flows       │  │                  │   │
│  └──────────────┘  └──────────────┘  └──────────────────┘   │
├─────────────────────────────────────────────────────────────┤
│                    DATA LAYER                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────┐   │
│  │  Customer__c │  │  Product__c  │  │  Order__c        │   │
│  │  Object      │  │  Object      │  │  Object          │   │
│  └──────────────┘  └──────────────┘  └──────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

---

## 3.2 Entity-Relationship Diagram (ERD)

```
┌─────────────────────┐         ┌─────────────────────┐
│    Customer__c      │         │    Product__c        │
├─────────────────────┤         ├─────────────────────┤
│ PK  Id              │         │ PK  Id              │
│     Name            │         │     Name            │
│     Phone__c        │         │     Stock_Quantity__c│
│     Email__c        │         │     Threshold__c     │
│     Address__c      │         │     Last_Updated__c  │
└──────────┬──────────┘         └──────────┬──────────┘
           │                               │
           │ 1                           1 │
           │                               │
           │ ∞                           ∞ │
           │                               │
┌──────────┴───────────────────────────────┴──────────┐
│                    Order__c                          │
├─────────────────────────────────────────────────────┤
│ PK  Id                                              │
│ FK  Customer__c  ──────▶ Customer__c.Id             │
│ FK  Product__c   ──────▶ Product__c.Id              │
│     Quantity__c                                     │
│     Status__c    (Pending|Processing|Shipped|Delivered) │
│     Priority__c  (High|Medium) — Auto-assigned      │
│     Order_Date__c                                   │
└─────────────────────────────────────────────────────┘
```

**Relationships:**
- **Customer → Order**: One-to-Many (One customer can have many orders)
- **Product → Order**: One-to-Many (One product can appear in many orders)

---

## 3.3 Data Flow Diagram (DFD) — Level 0

```
┌──────────┐                                    ┌──────────┐
│          │── Order Details ──▶┌──────────┐     │          │
│  Sales   │                   │          │     │ Warehouse│
│  Rep     │◀── Confirmation ──│ AgriEdge │──▶  │ Manager  │
│          │                   │   OMS    │     │(Alerts)  │
└──────────┘                   │          │     └──────────┘
                               │          │
┌──────────┐                   │          │     ┌──────────┐
│          │◀── Reports ───────│          │     │          │
│ Manager  │                   │          │──▶  │ Product  │
│          │◀── Dashboard ─────│          │     │ (Stock)  │
└──────────┘                   └──────────┘     └──────────┘
```

---

## 3.4 Data Flow Diagram (DFD) — Level 1

```
                    ┌─────────────┐
  Order Details ──▶ │ 1.0 Process │──▶ Priority Assigned
                    │   Order     │──▶ Task Created
                    └──────┬──────┘
                           │
                    Stock Update
                           │
                    ┌──────▼──────┐
                    │ 2.0 Update  │──▶ Stock Reduced
                    │  Inventory  │
                    └──────┬──────┘
                           │
                    Stock Level Check
                           │
                    ┌──────▼──────┐
                    │ 3.0 Check   │──▶ Alert Task (if low)
                    │  Threshold  │
                    └──────┬──────┘
                           │
                    Daily Schedule
                           │
                    ┌──────▼──────┐
                    │ 4.0 Adapt   │──▶ Threshold Adjusted
                    │  Threshold  │
                    └─────────────┘
```

---

## 3.5 Automation Design

### Flow 1: Order Creation Automation
```
┌───────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│  Trigger: │    │  Get Related │    │   Reduce     │    │   Create     │
│  Order    │──▶ │  Product     │──▶ │   Product    │──▶ │   Process    │
│  Created  │    │  (Get Records│    │   Stock      │    │   Task       │
└───────────┘    └──────────────┘    │  (Update)    │    │  (Create)    │
                                     └──────────────┘    └──────────────┘
```

### Flow 2: Low Stock Alert
```
┌───────────┐    ┌──────────────┐    ┌──────────────┐
│  Trigger: │    │  Decision:   │    │   Create     │
│  Product  │──▶ │  Stock <     │──▶ │   Alert      │
│  Updated  │    │  Threshold?  │    │   Task       │
└───────────┘    └──────┬───────┘    └──────────────┘
                        │ No
                        ▼
                   (End — No Action)
```

### Flow 3: Adaptive Threshold Logic
```
┌───────────┐    ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│ Schedule: │    │  Get Orders  │    │   Count      │    │  Decision:   │
│  Daily    │──▶ │  Last 7 Days │──▶ │   Orders     │──▶ │  Demand      │
│  Midnight │    │  (Get Records│    │  (Assignment)│    │  Level?      │
└───────────┘    └──────────────┘    └──────────────┘    └──────┬───────┘
                                                                │
                                              ┌─────────────────┼──────────────┐
                                              ▼                 ▼              ▼
                                        ┌───────────┐   ┌───────────┐   ┌───────────┐
                                        │ High      │   │ Low       │   │ Default   │
                                        │ Demand    │   │ Demand    │   │ (No       │
                                        │ +10       │   │ -5        │   │  Change)  │
                                        └───────────┘   └───────────┘   └───────────┘
```

---

## 3.6 UI/UX Design Decisions

| Component | Design Choice | Rationale |
|-----------|--------------|-----------|
| Navigation | Salesforce Lightning App with custom tabs | Familiar UI for enterprise users |
| Order Form | Standard Lightning Record Page | Consistent with Salesforce UX patterns |
| Dashboard | Donut Chart + Gauge Chart | Quick visual insight for managers |
| Alerts | Task-based notifications | Native to Salesforce; appears in user's task list |
| Status Tracking | Picklist with path component | Visual progress indicator on record page |

---

## 3.7 Security Design

| Layer | Mechanism | Description |
|-------|-----------|-------------|
| Authentication | Salesforce Login | Username/password + optional MFA |
| Authorization | Profiles & Permission Sets | Role-based access to objects and fields |
| Field-Level Security | Field accessibility settings | Restrict sensitive fields per profile |
| Record-Level Security | OWD + Sharing Rules | Control who sees which records |
| API Security | OAuth 2.0 | Secure external integrations |
