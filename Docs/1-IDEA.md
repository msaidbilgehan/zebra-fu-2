# TASK

MODE: BRAINSTORM & PLAN
AIM: DEVELOP AND IMPROVE IDEA THAN CREATE FINAL PLAN
SESSION: Q&A AND PLANNING
PROMPT: Start Q&A session fist, ask questions to user to understand, improve and develop the idea, after everything done, create deep dive plan.

## IDEA

When residents of the building send their maintenance fees to a bank account, they upload the receipt here. The system then extracts details such as the IBAN, sender, and recipient to clearly determine who has paid their fee. End-of-month data such as the total amount collected and the list of those who have not paid is tracked. Outputs such as Excel and PDF reports, as well as receipt details, can be downloaded, helping the building management handle tasks more efficiently.

### Features

- Receipt Recognition
- OCR
- Excel and PDF Reports
- Accounting
- Notifications, emails, messages

### Tech Stack

- Backend
  - Python Django
  - Celery
  - nginx
  - PostgreSQL
  - Docker

- Frontend
  - React
  - npm
  - Docker

- Mobile
  - React Native Cross-Platform IOS and Android App

### User Structure and Roles

- System Admin: The one controls and develops the platform. All features, all record, full management available, full control.
- Residents (Residents / Payers / Tenants): Unit payers, tenant
- Managers (Building Managers or Property Managers): The one collecting maintenance fees of buildings from every residents
- Management Company: Residential complex manager company that has their own Accountants

#### Recommended hierarchy

There are two branches in hierarchy. One is for Management Company that can manage multiple buildings or managing residential complex, and other one is the one building managers that can manage only one building and related residents.

- Platform
  - Management Company
    - Subscription Management
    - Building(s)
      - Apartment(s)
        - Residents / Payers
  - Managers of one Building
    - Subscription Management
    - Building
      - Apartments
        - Residents / Payers

### Platform Payments

Implement subscription model that is monthly and yearly payment with discount code supported structure. Use one or more payment platform integration.

### Residents Payment Flow

1) Residents transfer to one building bank account, then upload the receipt manually
2) Manager upload the receipts manually for the related residents

### Q&A

- **How should the system identify the payer?**
  - By matching uploaded receipt to a resident/unit manually if OCR is uncertain

- **How many buildings and apartments should the first version support?**
  - One building or multiple buildings under one management company

- **What happens when OCR is wrong or incomplete?**
  - Manager reviews flagged receipts
  - Resident confirms/edit details
  - System stores low-confidence items for manual approval

- Which receipt sources must be supported first?
  - PDF transfer receipt

- **Are payments always monthly maintenance fees, or also other charges?**
  - Monthly dues only
  - Late fees
  - Repair/special assessment
  - Utility/shared costs
  - Deposits/other building payments

- **What reports matter most?**
  - Monthly collection summary
  - Paid/unpaid resident list
  - Unit ledger/history
  - Export for accountant
  - Management board PDF summary

- **What notifications do you want first?**
  - Payment received confirmation
  - Reminder before due date
  - Late payment reminder
  - Manager alert for OCR failure
  - Monthly summary email

- **Which communication channels are required?**
  - Email
  - Push notifications in mobile app

- **What languages and regions must be supported?**
  - Turkish + English

- **What level of accounting is expected?**
  - Basic cash tracking/reporting
  - Monthly ledger per unit
  - Full accounting/journal entries

- **What legal/compliance constraints matter?**
  - Personal data protection requirements
  - Audit trail of edits/actions
  - Document retention period (2 years)
  - Need for admin approval before records become official

- **What should be downloadable?**
  - Excel reports
  - PDF reports
  - Original receipts
  - Monthly archive bundle

- **What is the business model?**
  - SaaS for many building managers
  - Per building subscription
  - Per unit/apartment pricing

- **What is the single biggest pain point you want this product to solve first?**
  - Proving who paid
  - Saving manager time
  - Chasing unpaid residents
  - Accurate monthly reporting
  - Reducing accounting mistakes
