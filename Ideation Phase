# 💡 Phase 1: Ideation

## Project Title
**Smart Order Management System (OMS) for AgriEdge Or-Mange Ltd**

## Domain
Agriculture & Food Production — Supply Chain Management

## Problem Identification

AgriEdge Or-Mange Ltd, a mid-scale agriculture and food production company, is experiencing severe operational bottlenecks in its order management process. Through stakeholder interviews and operational audits, the following pain points were identified:

### Pain Point 1: Manual Order Processing Errors
- Orders are currently recorded using spreadsheets and paper-based systems
- Human errors in data entry lead to incorrect shipments (estimated 12% error rate)
- No automated priority classification — urgent orders are treated the same as routine ones

### Pain Point 2: Lack of Real-Time Inventory Visibility
- Warehouse managers rely on end-of-day reports to check stock levels
- Stockouts are discovered only when a customer complains
- No predictive system to anticipate demand fluctuations across seasons

### Pain Point 3: Disconnected Customer Service Channels
- Customer service representatives have no unified view of order status
- Customers call multiple times for the same update
- No automated task assignment — follow-ups are missed regularly

## Brainstorming Sessions

### Session 1: Platform Selection
| Option | Pros | Cons | Decision |
|--------|------|------|----------|
| Custom Web App (React/Node) | Full control, flexible UI | High dev cost, no CRM features | ❌ Rejected |
| SAP ERP | Industry standard, powerful | Extremely expensive, complex setup | ❌ Rejected |
| **Salesforce Platform** | **CRM-native, automation tools, low code, scalable** | **Learning curve** | ✅ **Selected** |

**Rationale:** Salesforce provides built-in automation (Flows, Apex Triggers), a robust data model, and enterprise-grade reporting — all critical for an OMS without building from scratch.

### Session 2: Novelty Feature Ideation
| Idea | Feasibility | Innovation Score | Decision |
|------|-------------|-----------------|----------|
| AI-based demand prediction | Low (requires ML pipeline) | 9/10 | ❌ Too complex |
| Static threshold alerts | High | 3/10 | ❌ Not novel |
| **Adaptive Smart Thresholds** | **High (achievable with Flows)** | **8/10** | ✅ **Selected** |

**Why Adaptive Thresholds?** — Unlike static systems, our thresholds learn from real order data. If fertilizer demand spikes during monsoon season, the system automatically raises the reorder point. During off-season, it reduces it to save warehousing costs.

## Initial Concept Map

```
                    ┌─────────────────┐
                    │   AgriEdge OMS  │
                    └────────┬────────┘
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
     ┌────────────┐  ┌────────────┐  ┌────────────┐
     │   Order    │  │ Inventory  │  │  Customer  │
     │ Automation │  │ Management │  │  Service   │
     └─────┬──────┘  └─────┬──────┘  └─────┬──────┘
           │               │               │
     ┌─────▼──────┐  ┌─────▼──────┐  ┌─────▼──────┐
     │ Priority   │  │ Adaptive   │  │ Unified    │
     │ Assignment │  │ Thresholds │  │ Dashboard  │
     │ (Apex)     │  │ (Flow)     │  │ (Reports)  │
     └────────────┘  └────────────┘  └────────────┘
```

## Feasibility Assessment

| Criterion | Assessment | Status |
|-----------|-----------|--------|
| Technical Feasibility | Salesforce Developer Edition is free; Apex & Flows support all requirements | ✅ Feasible |
| Operational Feasibility | System replaces manual processes with zero disruption to existing workflows | ✅ Feasible |
| Economic Feasibility | Zero licensing cost (Developer Edition); reduces operational errors by ~80% | ✅ Feasible |
| Time Feasibility | Can be built and deployed within 2-week sprint cycle | ✅ Feasible |

## Outcome
The ideation phase confirmed that building a **Salesforce-native OMS with Adaptive Smart Thresholds** is the optimal solution for AgriEdge Or-Mange Ltd's operational challenges.
