# Local DevOps Release Platform

**Tectigon Academy — Praktika DevOps, Qershor 2026**
**Kandidati:** Orik Bojniku | orikbojniku6@gmail.com

---

## Pershkrimi

Platforme e plote DevOps CI/CD qe funksionon teresisht lokalisht, pa sherbime cloud. Simulon nje workflow te mjedisit te prodhimit real duke perfshire automatizimin e ndertimit, testimit, skanimit te sigurise dhe vendosjes se aplikacioneve.

---

## Teknologjite

| Teknologjia | Perdorimi | Versioni |
|-------------|-----------|----------|
| Git & GitHub | Version control | 2.53+ |
| Docker | Kontejnerizimi | 29.4+ |
| Jenkins | CI/CD Pipeline | LTS |
| Kubernetes (Kind) | Orkestrimi lokal | v1.35 |
| Terraform | Infrastruktura si kod | v1.15+ |
| Ansible | Menaxhimi i konfigurimit | v2.20+ |
| Trivy | Skanimi i sigurise | v0.71+ |
| PostgreSQL | Baza e te dhenave | v15 |

---

## Pipeline CI/CD — 10 Fazat

| Faza | Pershkrimi |
|------|------------|
| 1. Checkout | Merr kodin nga GitHub |
| 2. Lint & Unit Tests | Teston API dhe Worker paralel |
| 3. Build Docker Images | Nderton imazhet me BUILD_NUMBER |
| 4. Security Scan | Trivy skanon vulnerabilitetet |
| 5. Push to Registry | Ngarkon imazhet ne registry lokal |
| 6. Deploy to Dev | Vendos ne namespace dev |
| 7. Smoke Tests | Teston health endpoint |
| 8. Manual Approval | Pret aprovimin para Stage |
| 9. Promote to Stage | Promovon ne namespace stage |
| 10. Rollback | Rikthim automatik nese deshtoi |

---

## Kriteret e Pranimit

- [x] Platforma ekzekutohet lokalisht
- [x] Bootstrap me Ansible dhe Terraform
- [x] Pipeline CI/CD end-to-end pa nderhyrje manuale
- [x] Blue/Green deployment i validuar
- [x] Rollback automatik i validuar
- [x] README dokumenton workflow-n e plote

---

*Data e Fillimit: 09/06/2026 | Data e Perfundimit: 04/07/2026*
