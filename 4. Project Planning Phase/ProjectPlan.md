# 📅 Phase 4: Project Planning

## 4.1 Project Timeline (Gantt Chart)

```
Week 1                    Week 2                    Week 3                    Week 4
├─────────────────────────┼─────────────────────────┼─────────────────────────┼──────────────┤
│▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│                         │                         │              │
│ Phase 1: Ideation &     │                         │                         │              │
│ Requirement Analysis    │                         │                         │              │
├─────────────────────────┼─────────────────────────┤                         │              │
│                         │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│                         │              │
│                         │ Phase 2: Design &       │                         │              │
│                         │ Planning                │                         │              │
├─────────────────────────┼─────────────────────────┼─────────────────────────┤              │
│                         │                         │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│              │
│                         │                         │ Phase 3: Development    │              │
│                         │                         │ & Testing               │              │
├─────────────────────────┼─────────────────────────┼─────────────────────────┼──────────────┤
│                         │                         │                         │▓▓▓▓▓▓▓▓▓▓▓▓▓│
│                         │                         │                         │ Phase 4:     │
│                         │                         │                         │ Documentation│
│                         │                         │                         │ & Demo       │
└─────────────────────────┴─────────────────────────┴─────────────────────────┴──────────────┘
```

---

## 4.2 Work Breakdown Structure (WBS)

```
AgriEdge OMS Project
│
├── 1.0 Initiation
│   ├── 1.1 Problem Identification
│   ├── 1.2 Stakeholder Interviews
│   └── 1.3 Feasibility Study
│
├── 2.0 Planning
│   ├── 2.1 Requirement Gathering
│   ├── 2.2 Use Case Documentation
│   ├── 2.3 Architecture Design
│   └── 2.4 Risk Assessment
│
├── 3.0 Development
│   ├── 3.1 Salesforce Org Setup
│   ├── 3.2 Custom Object Creation
│   │   ├── 3.2.1 Customer Object
│   │   ├── 3.2.2 Product Object
│   │   └── 3.2.3 Order Object
│   ├── 3.3 Apex Development
│   │   ├── 3.3.1 Order Priority Trigger
│   │   └── 3.3.2 Test Class
│   ├── 3.4 Flow Development
│   │   ├── 3.4.1 Order Creation Automation
│   │   ├── 3.4.2 Low Stock Alert
│   │   └── 3.4.3 Adaptive Threshold Logic
│   └── 3.5 Reports & Dashboards
│
├── 4.0 Testing
│   ├── 4.1 Unit Testing (Apex)
│   ├── 4.2 Integration Testing
│   └── 4.3 User Acceptance Testing
│
└── 5.0 Deployment & Documentation
    ├── 5.1 Final Documentation
    ├── 5.2 Project Demo Preparation
    └── 5.3 Viva Presentation
```

---

## 4.3 Sprint Planning

### Sprint 1 (Week 1-2): Foundation
| Task | Estimated Hours | Status |
|------|----------------|--------|
| Set up Salesforce Developer Org | 1 | ✅ Done |
| Create Customer__c Object + Fields | 1 | ✅ Done |
| Create Product__c Object + Fields | 1 | ✅ Done |
| Create Order__c Object + Fields | 2 | ✅ Done |
| Create Custom Tabs for all objects | 1 | ✅ Done |
| Write Apex Trigger (NewOrderTrigger) | 3 | ✅ Done |
| Write Apex Test Class | 2 | ✅ Done |
| **Sprint 1 Total** | **11 hours** | |

### Sprint 2 (Week 3): Automation
| Task | Estimated Hours | Status |
|------|----------------|--------|
| Build Flow 1: Order Creation Automation | 3 | ✅ Done |
| Build Flow 2: Low Stock Alert | 2 | ✅ Done |
| Build Flow 3: Adaptive Threshold Logic | 4 | ✅ Done |
| Create Reports (Orders by Status, Urgent) | 2 | ✅ Done |
| Build Operations Dashboard | 2 | ✅ Done |
| **Sprint 2 Total** | **13 hours** | |

### Sprint 3 (Week 4): Polish & Documentation
| Task | Estimated Hours | Status |
|------|----------------|--------|
| Create test data (Products, Customers, Orders) | 2 | ✅ Done |
| End-to-end testing | 3 | ✅ Done |
| Write project documentation | 4 | ✅ Done |
| Prepare demo script | 2 | ✅ Done |
| **Sprint 3 Total** | **11 hours** | |

---

## 4.4 Risk Assessment

| # | Risk | Probability | Impact | Mitigation Strategy |
|---|------|-------------|--------|---------------------|
| R1 | Salesforce API limits exceeded | Low | High | Use bulk patterns in Apex; batch processing |
| R2 | Apex test coverage below 75% | Medium | High | Write comprehensive test class with 3+ methods |
| R3 | Flow errors during activation | Medium | Medium | Test with Debug mode before activating |
| R4 | Data model changes mid-project | Low | High | Finalize ERD before development begins |
| R5 | Scheduled flow timing conflicts | Low | Medium | Set non-peak execution times (midnight) |

---

## 4.5 Resource Allocation

| Resource | Role | Responsibility |
|----------|------|----------------|
| Developer | Salesforce Developer | Apex code, Flow configuration, Object setup |
| Tester | QA Engineer | Test case execution, UAT coordination |
| Project Lead | Project Manager | Timeline tracking, documentation, stakeholder communication |

---

## 4.6 Tools Used

| Purpose | Tool |
|---------|------|
| Platform | Salesforce Developer Edition |
| Code Editor | Salesforce Developer Console |
| Version Control | GitHub |
| Documentation | Markdown (README, Setup Guide) |
| Project Management | Manual Sprint Tracking |
| Testing | Apex Test Framework |
