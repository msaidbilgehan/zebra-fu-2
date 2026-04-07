# IDEA - aidatlar.net

When residents of the building send their maintenance fees to a bank account, they upload the receipt here. The system then extracts details such as the IBAN, sender, and recipient to clearly determine who has paid their fee. End-of-month data such as the total amount collected and the list of those who have not paid is tracked. Outputs such as Excel and PDF reports, as well as receipt details, can be downloaded, helping the building management handle tasks more efficiently.

## Core Value Proposition

**"Who paid, who didn't, prove it."** — The platform replaces the WhatsApp + Excel chaos that most Turkish building managers deal with today. It provides a structured, auditable payment tracking system that requires minimal effort from both managers and residents.

## Competitive Differentiators

The real competitor is not Apsiyon or other apartment management software — it is **WhatsApp groups + Excel spreadsheets**. Most small/medium buildings use no software at all. The platform wins by being **slightly more structured than WhatsApp** and **10x less effort than Excel**.

### Key differentiators over alternatives

1. **WhatsApp/Telegram Bot Integration** — Residents send receipt photos to a bot number. No app download, no login, no friction. This alone eliminates the biggest adoption barrier.
2. **Payment Status Board** — Public or PIN-protected page showing which units have paid. Social pressure does the collection work. Managers love this.
3. **One-Tap Reminders** — Manager hits one button, all unpaid residents get a personalized reminder (SMS/WhatsApp) with their amount and a "mark as paid" link.
4. **Accountant Portal** — Read-only access with export. Accountants become a distribution channel: "tell your other buildings to use this."
5. **Payment Verification Badge** — Residents get a verifiable "paid" status they can screenshot or share. Eliminates "I paid but manager says I didn't" disputes permanently.
6. **Instant Month-End PDF** — Auto-generated, branded, board-ready summary. No manual assembly required.
7. **Zero-Effort Setup** — Enter building name, unit count, bank IBAN, done. Value on day one even with zero receipts uploaded.

### The Killer Combo

**WhatsApp bot + payment status board + one-click reminders** covers the entire pain cycle:

1. Resident pays → sends receipt to WhatsApp bot (zero friction)
2. Manager sees it on dashboard → approves/flags
3. Status board updates → social pressure on non-payers
4. One tap → reminders go out to remaining unpaid units
5. Month end → PDF auto-generated

## Features

### v1 (MVP — Web Only)

- **Payment ledger** — Manual paid/unpaid tracking per unit per month (core, works without OCR)
- **Receipt storage** — Upload and attach receipts to payments (file upload, no OCR required)
- **Payment status board** — Shareable page showing paid/unpaid status per unit
- **One-click reminders** — Bulk SMS/WhatsApp reminders to unpaid residents
- **Monthly reports** — Auto-generated PDF and Excel exports
- **Accountant portal** — Read-only access with export capabilities
- **Resident self-service page** — Magic link or unit code access, no account required. "I paid, here's proof" with file upload
- **Notifications** — Email-based payment confirmations, reminders, and monthly summaries

### v2 (Growth)

- **WhatsApp/Telegram bot** — Residents send receipt photos to a bot; system processes and attaches to their unit
- **OCR (optional enhancement)** — Extract IBAN, sender, amount from receipts. Flagged for manual review when confidence is low
- **Payment verification badge** — Verifiable "paid" status residents can share
- **Push notifications** — In-app notifications via web push

### v3 (Scale)

- **Mobile app** — React Native cross-platform (iOS and Android)
- **Bank API integration** — Match payments via unique reference codes in transfer descriptions (Open Banking)
- **Full accounting/journal entries** — Beyond basic cash tracking
- **Advanced analytics** — Payment trends, delinquency predictions, building comparisons

## Tech Stack

### v1

- **Backend:** Python Django, Celery (async tasks), nginx, PostgreSQL, Docker
- **Frontend:** React (responsive web app, mobile-friendly), npm, Docker
- **Infrastructure:** Docker Compose for local dev and deployment

### v2+

- **Messaging:** WhatsApp Business API / Telegram Bot API
- **OCR:** Optional — Tesseract or cloud OCR service as enhancement layer
- **Mobile:** React Native (deferred to v3, not v1)

> **Decision:** No mobile app in v1. Web-first, mobile-responsive. Residents don't need an app — they need a page. This cuts scope significantly and accelerates time-to-market.

## User Structure and Roles

- **System Admin:** Platform operator. Full control over all features, records, and management.
- **Residents (Payers / Tenants):** Unit payers. Minimal interaction required — upload receipt or send via bot. No mandatory account creation in v1 (magic link / unit code access).
- **Managers (Building Managers / Property Managers):** Primary paying customer. Collects maintenance fees, tracks payments, generates reports.
- **Management Company:** Manages multiple buildings. Has own accountants with read-only portal access.
- **Accountant (v1):** Read-only access to financial data and exports. Potential distribution channel.

### Recommended hierarchy

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

## Platform Payments

Implement subscription model that is monthly and yearly payment with discount code supported structure. Use one or more payment platform integration.

- **Freemium tier:** 1 building, basic features (drives adoption)
- **Paid tier:** Multi-building, advanced reports, accountant portal, bot integration
- **Pricing model:** Per building subscription + optional per-unit pricing for large complexes

## Residents Payment Flow

### Primary flow (v1)

1. Resident transfers to building's bank account
2. Resident visits self-service page (magic link / unit code) and uploads receipt — OR manager uploads receipt on behalf of resident
3. Manager reviews and approves payment on dashboard

### Enhanced flow (v2 — WhatsApp bot)

1. Resident transfers to building's bank account
2. Resident sends receipt photo to WhatsApp/Telegram bot
3. System attaches receipt to resident's unit
4. Manager reviews and approves on dashboard

### Future flow (v3 — Bank API)

1. Manager shares a unique payment reference per unit/month (code in transfer description)
2. Resident transfers money including the code
3. System matches payments automatically via bank API integration
4. OCR becomes a fallback, not the primary path

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
| --- | --- | --- | --- |
| **Managers won't switch from WhatsApp/Excel** — "works fine" | High | High | Offer migration service; import existing Excel data. Make setup under 5 minutes. Deliver value on day one. |
| **OCR accuracy too low** — manual work negates time saved | High | Medium | OCR is optional/secondary in v1. Core product is manual ledger + receipt storage. OCR enhances, not enables. |
| **Residents won't download another app** | Medium | High | No app in v1. Web-only for residents. No login required (magic link / unit code). WhatsApp bot in v2 meets them where they already are. |
| **Competitors add same features** | Medium | Medium | Move fast. Nail the UX for Turkish market specifically. WhatsApp bot + status board combo is hard to replicate quickly in bloated platforms. |
| **Subscription price sensitivity** | Medium | Medium | Freemium for 1 building. Paid for multi-building/company. Keep entry price low. |
| **Turkish bank receipt format variability** (for OCR) | High | Low (v1) | OCR deferred to v2. When implemented, support major banks first. Manual fallback always available. |
| **WhatsApp Business API cost/approval** | Medium | Medium | Start with Telegram bot (free, easier API). Add WhatsApp when revenue justifies cost. |
| **Data protection / KVKK compliance** | Low | High | Design for compliance from day one. Audit trail, data retention policies, no PII in logs. |

## Q&A

- **How should the system identify the payer?**
  - v1: Manual matching — resident uploads to their own unit page, or manager assigns receipt to unit
  - v2: WhatsApp bot identifies resident by phone number linked to unit
  - v3: Bank API matches by unique payment reference code

- **How many buildings and apartments should the first version support?**
  - One building or multiple buildings under one management company

- **What happens when OCR is wrong or incomplete?**
  - OCR is not in v1 scope
  - v2+: Manager reviews flagged receipts. Resident confirms/edits details. System stores low-confidence items for manual approval.

- **Which receipt sources must be supported first?**
  - Any image or PDF file upload (receipt stored as-is, no OCR processing in v1)

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
  - Monthly summary email

- **Which communication channels are required?**
  - v1: Email + SMS/WhatsApp reminders (outbound only)
  - v2: WhatsApp/Telegram bot (inbound receipt upload)
  - v3: Push notifications in mobile app

- **What languages and regions must be supported?**
  - Turkish + English

- **What level of accounting is expected?**
  - v1: Basic cash tracking/reporting + monthly ledger per unit
  - v3: Full accounting/journal entries

- **What legal/compliance constraints matter?**
  - KVKK (Turkish personal data protection) compliance
  - Audit trail of edits/actions
  - Document retention period (2 years)
  - Need for admin approval before records become official

- **What should be downloadable?**
  - Excel reports
  - PDF reports
  - Original receipts
  - Monthly archive bundle

- **What is the business model?**
  - SaaS for building managers
  - Freemium: 1 building free, paid for multi-building
  - Per building subscription + optional per-unit pricing

- **What is the single biggest pain point you want this product to solve first?**
  - **Proving who paid** (primary — this is the trust problem)
  - Chasing unpaid residents (status board + reminders)
  - Saving manager time (auto-reports, one-click actions)
  - Accurate monthly reporting
  - Reducing accounting mistakes
