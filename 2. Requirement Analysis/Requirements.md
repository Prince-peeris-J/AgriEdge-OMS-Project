# 📋 Phase 2: Requirement Analysis

## 2.1 Functional Requirements

### FR-01: Order Management
| ID | Requirement | Priority | MoSCoW |
|----|-------------|----------|--------|
| FR-01.1 | System shall allow creation of orders with Order ID, Customer, Product, Quantity, Status, and Priority fields | High | Must Have |
| FR-01.2 | System shall automatically assign priority (High/Medium) based on stock levels and order quantity | High | Must Have |
| FR-01.3 | System shall support order status transitions: Pending → Processing → Shipped → Delivered | High | Must Have |
| FR-01.4 | System shall automatically generate a processing task when a new order is created | Medium | Should Have |
| FR-01.5 | System shall track order history with timestamps | Low | Could Have |

### FR-02: Inventory Management
| ID | Requirement | Priority | MoSCoW |
|----|-------------|----------|--------|
| FR-02.1 | System shall maintain real-time inventory records for each product | High | Must Have |
| FR-02.2 | System shall automatically deduct stock when an order is placed | High | Must Have |
| FR-02.3 | System shall trigger alerts when stock falls below the threshold | High | Must Have |
| FR-02.4 | System shall support adaptive threshold adjustment based on demand patterns | High | Must Have |

### FR-03: Customer Management
| ID | Requirement | Priority | MoSCoW |
|----|-------------|----------|--------|
| FR-03.1 | System shall maintain customer records with name, phone, email, and address | High | Must Have |
| FR-03.2 | System shall link orders to customer records via lookup relationship | High | Must Have |

### FR-04: Reporting & Analytics
| ID | Requirement | Priority | MoSCoW |
|----|-------------|----------|--------|
| FR-04.1 | System shall provide a report of orders grouped by status | Medium | Should Have |
| FR-04.2 | System shall provide a report of high-priority/urgent orders | Medium | Should Have |
| FR-04.3 | System shall provide an executive dashboard with visual charts | Medium | Should Have |

---

## 2.2 Non-Functional Requirements

| ID | Requirement | Category |
|----|-------------|----------|
| NFR-01 | System shall be accessible via any modern web browser | Accessibility |
| NFR-02 | All automations shall execute within 5 seconds of trigger event | Performance |
| NFR-03 | System shall enforce Salesforce security model (profiles, permissions) | Security |
| NFR-04 | Apex code shall have ≥75% test coverage | Maintainability |
| NFR-05 | System shall be scalable to handle 10,000+ order records | Scalability |
| NFR-06 | UI shall follow Salesforce Lightning Design System standards | Usability |

---

## 2.3 Use Case Diagram

```
                        ┌─────────────────────────────────────┐
                        │        AgriEdge OMS System          │
                        │                                     │
  ┌──────────┐          │  ┌─────────────────────────────┐    │
  │          │─────────▶│  │  UC-01: Create New Order     │    │
  │          │          │  └─────────────────────────────┘    │
  │          │          │  ┌─────────────────────────────┐    │
  │  Sales   │─────────▶│  │  UC-02: View Order Status    │    │
  │  Rep     │          │  └─────────────────────────────┘    │
  │          │          │  ┌─────────────────────────────┐    │
  │          │─────────▶│  │  UC-03: Update Order Status  │    │
  └──────────┘          │  └─────────────────────────────┘    │
                        │                                     │
  ┌──────────┐          │  ┌─────────────────────────────┐    │
  │          │─────────▶│  │  UC-04: Add/Update Products  │    │
  │ Warehouse│          │  └─────────────────────────────┘    │
  │ Manager  │          │  ┌─────────────────────────────┐    │
  │          │─────────▶│  │  UC-05: View Stock Alerts    │    │
  └──────────┘          │  └─────────────────────────────┘    │
                        │                                     │
  ┌──────────┐          │  ┌─────────────────────────────┐    │
  │          │─────────▶│  │  UC-06: View Dashboard       │    │
  │ Manager  │          │  └─────────────────────────────┘    │
  │          │          │  ┌─────────────────────────────┐    │
  │          │─────────▶│  │  UC-07: Generate Reports     │    │
  └──────────┘          │  └─────────────────────────────┘    │
                        │                                     │
  ┌──────────┐          │  ┌─────────────────────────────┐    │
  │ System   │─────────▶│  │  UC-08: Auto-Assign Priority│    │
  │ (Auto)   │          │  └─────────────────────────────┘    │
  │          │          │  ┌─────────────────────────────┐    │
  │          │─────────▶│  │  UC-09: Adjust Thresholds   │    │
  └──────────┘          │  └─────────────────────────────┘    │
                        └─────────────────────────────────────┘
```

---

## 2.4 Use Case Descriptions

### UC-01: Create New Order
| Field | Description |
|-------|-------------|
| **Actor** | Sales Representative |
| **Precondition** | Customer and Product records exist |
| **Main Flow** | 1. User clicks "New" on Order tab → 2. Selects Customer and Product → 3. Enters Quantity → 4. Clicks Save |
| **Post-condition** | Order is saved with auto-assigned Priority; stock is reduced; processing task is created |
| **Alternate Flow** | If Product field is empty, Priority defaults to "Medium" |

### UC-08: Auto-Assign Priority (System)
| Field | Description |
|-------|-------------|
| **Actor** | System (Apex Trigger) |
| **Precondition** | New order is being inserted |
| **Main Flow** | 1. Trigger fires → 2. Queries Product's stock and threshold → 3. Compares stock vs threshold and quantity vs 50 → 4. Sets Priority |
| **Post-condition** | Order.Priority__c is set to "High" or "Medium" |
| **Business Rule** | High if (Stock < Threshold) OR (Quantity > 50); else Medium |

### UC-09: Adjust Thresholds (System)
| Field | Description |
|-------|-------------|
| **Actor** | System (Scheduled Flow — runs daily at midnight) |
| **Precondition** | Products exist with order history |
| **Main Flow** | 1. Flow queries orders from last 7 days per product → 2. Counts order volume → 3. If ≥10, increase threshold by 10 → 4. If <3, decrease threshold by 5 |
| **Post-condition** | Product.Threshold__c is updated |

---

## 2.5 Stakeholder Analysis

| Stakeholder | Role | Interest | Influence |
|-------------|------|----------|-----------|
| Sales Team | Create and track orders | High | Medium |
| Warehouse Staff | Monitor stock levels | High | Medium |
| Operations Manager | View dashboards, make decisions | High | High |
| IT Administrator | Maintain system, deploy updates | Medium | High |
| Customers (External) | Receive timely deliveries | High | Low |
