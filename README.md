# FIRSTSecurePay – Secure Digital Banking Platform

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Java](https://img.shields.io/badge/Java-17+-orange.svg)](https://openjdk.org/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![React](https://img.shields.io/badge/React-18-blue.svg)](https://reactjs.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue.svg)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue.svg)](https://www.docker.com/)

> A production-oriented full-stack digital banking application that combines **secure authentication**, **unified payments orchestration**, and a **personalized insights dashboard**.

---

## 📌 Overview

**FIRSTSecurePay** is a comprehensive digital banking platform designed to demonstrate enterprise-grade application engineering practices. It integrates three critical banking domains into one cohesive system:

1. **Secure Authentication & Session Management** – Multi-factor authentication, risk-based controls, JWT with rotation, and device binding.
2. **Unified Payments Hub** – Single orchestration layer supporting UPI, Cards, Net Banking, and Bill Payments with idempotency, reconciliation, and basic fraud checks.
3. **Personalized Banking Dashboard & Insights** – Real-time balances, transaction categorization, spending insights, and actionable recommendations.

The project follows clean architecture principles, coding standards, full SDLC practices, and is fully containerized for easy local development and deployment.

---

## ✨ Key Features

### Authentication & Security
- Multi-factor authentication (Password + OTP)
- Risk-based authentication (location, device, velocity checks)
- JWT access + refresh token rotation
- Device binding and trusted device management
- Role-Based Access Control (RBAC)
- Secure session management and forced logout
- Full audit logging of authentication events

### Unified Payments
- Single payment initiation experience across multiple rails:
  - UPI (P2P / P2M)
  - Debit / Credit Cards (tokenized)
  - Net Banking
  - Bill Payments
- Idempotency keys and strong consistency
- Automatic retry and compensation logic
- Real-time payment status tracking
- Reconciliation engine
- Basic rule-based fraud detection
- Beneficiary management and payment limits

### Personalized Dashboard & Insights
- Real-time account overview and balances
- Transaction history with advanced search & filters
- Automatic transaction categorization
- Spending trends and category-wise insights
- Personalized recommendations and goal tracking
- Customizable widgets and quick actions

### Additional Capabilities
- Consent & preference management
- Real-time notifications (in-app + event-driven)
- Technical documentation and API specs
- Docker-based local development environment
- Health checks and basic observability

---

## 🛠 Tech Stack

| Layer              | Technology                                      |
|--------------------|-------------------------------------------------|
| Backend            | Java 17+, Spring Boot 3.2, Spring Security      |
| Frontend           | React 18, TypeScript, Vite                      |
| Database           | PostgreSQL 15                                   |
| Cache / Sessions   | Redis 7                                         |
| Messaging          | (Optional) Apache Kafka / RabbitMQ              |
| Authentication     | JWT (Access + Refresh), OTP                     |
| Containerization   | Docker, Docker Compose                          |
| API Documentation  | SpringDoc OpenAPI (Swagger)                     |
| Build Tools        | Maven (Backend), npm / Vite (Frontend)          |

---

## 🏗 High-Level Architecture

```
┌─────────────────┐     ┌──────────────────────┐     ┌─────────────────────┐
│  React Frontend │────▶│   API Gateway /      │────▶│  Auth Service       │
│  (Web + Mobile  │     │   Spring Boot App    │     │  Payments Service   │
│   ready)        │     │                      │     │  Insights Service   │
└─────────────────┘     └──────────────────────┘     │  Notification Svc   │
                                                      └─────────────────────┘
                                                               │
                                                      ┌────────┴────────┐
                                                      │                 │
                                                 PostgreSQL          Redis
```

---

## 📁 Project Structure

```
FIRSTSecurePay/
├── backend/                          # Spring Boot application
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/firstsecurepay/
│   │   │   │   ├── FirstSecurePayApplication.java
│   │   │   │   ├── config/                   # Security, Redis, OpenAPI configs
│   │   │   │   ├── controller/               # REST Controllers
│   │   │   │   │   ├── AuthController.java
│   │   │   │   │   ├── PaymentController.java
│   │   │   │   │   ├── DashboardController.java
│   │   │   │   │   └── UserController.java
│   │   │   │   ├── dto/                      # Request/Response DTOs
│   │   │   │   ├── entity/                   # JPA Entities
│   │   │   │   ├── repository/               # Spring Data JPA Repositories
│   │   │   │   ├── service/                  # Business Logic
│   │   │   │   │   ├── AuthService.java
│   │   │   │   │   ├── PaymentService.java
│   │   │   │   │   ├── InsightsService.java
│   │   │   │   │   ├── RiskEngine.java
│   │   │   │   │   └── NotificationService.java
│   │   │   │   ├── security/                 # JWT filter, UserDetails, etc.
│   │   │   │   ├── exception/                # Global exception handling
│   │   │   │   └── util/                     # Helpers & constants
│   │   │   └── resources/
│   │   │       ├── application.yml
│   │   │       ├── application-dev.yml
│   │   │       ├── application-prod.yml
│   │   │       └── db/migration/             # Flyway / Liquibase scripts (optional)
│   │   └── test/                             # Unit & Integration tests
│   ├── pom.xml
│   └── Dockerfile
│
├── frontend/                         # React + TypeScript application
│   ├── public/
│   ├── src/
│   │   ├── api/                      # Axios / Fetch API clients
│   │   ├── components/               # Reusable UI components
│   │   │   ├── auth/
│   │   │   ├── dashboard/
│   │   │   ├── payments/
│   │   │   └── common/
│   │   ├── pages/                    # Route-level pages
│   │   ├── hooks/                    # Custom React hooks
│   │   ├── context/                  # Auth & Theme context
│   │   ├── types/                    # TypeScript interfaces
│   │   ├── utils/                    # Helpers
│   │   ├── App.tsx
│   │   ├── main.tsx
│   │   └── index.css
│   ├── package.json
│   ├── vite.config.ts
│   ├── tsconfig.json
│   └── Dockerfile
│
├── docs/                             # Documentation
│   ├── architecture.md
│   ├── api-specification.md
│   ├── sequence-diagrams.md
│   └── user-manual.md
│
├── scripts/                          # Utility scripts
│   ├── init-db.sql
│   └── seed-data.sql
│
├── docker-compose.yml                # Full local stack
├── .env.example                      # Environment variable template
├── .gitignore
├── LICENSE
└── README.md                         # You are here
```

---

## 📋 Prerequisites

Make sure the following are installed on your machine:

- **Java 17** or higher
- **Maven 3.8+**
- **Node.js 18+** and npm
- **Docker** and **Docker Compose** (recommended)
- **Git**
- (Optional) PostgreSQL 15 and Redis 7 if running without Docker

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/FIRSTSecurePay.git
cd FIRSTSecurePay
```

### 2. Configure Environment Variables

Copy the example environment file and update the values:

```bash
cp .env.example .env
```

Edit `.env` with your preferred settings (database credentials, JWT secret, etc.).

**Important variables:**

| Variable                    | Description                              | Example Value                  |
|----------------------------|------------------------------------------|--------------------------------|
| `DB_HOST`                  | PostgreSQL host                          | `localhost` or `postgres`      |
| `DB_PORT`                  | PostgreSQL port                          | `5432`                         |
| `DB_NAME`                  | Database name                            | `firstsecurepay`               |
| `DB_USER`                  | Database username                        | `postgres`                     |
| `DB_PASSWORD`              | Database password                        | `your_secure_password`         |
| `REDIS_HOST`               | Redis host                               | `localhost` or `redis`         |
| `REDIS_PORT`               | Redis port                               | `6379`                         |
| `JWT_SECRET`               | Secret key for signing JWTs (min 32 chars)| `your-very-long-secret-key...` |
| `JWT_ACCESS_EXPIRATION`    | Access token expiry (ms)                 | `900000` (15 min)              |
| `JWT_REFRESH_EXPIRATION`   | Refresh token expiry (ms)                | `604800000` (7 days)           |
| `OTP_EXPIRY_SECONDS`       | OTP validity                             | `300`                          |
| `FRONTEND_URL`             | Allowed CORS origin                      | `http://localhost:5173`        |

### 3. Run with Docker Compose (Recommended)

This starts PostgreSQL, Redis, Backend, and Frontend in one command:

```bash
docker-compose up --build
```

Once all services are healthy:

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:8080
- **Swagger UI**: http://localhost:8080/swagger-ui.html
- **Health Check**: http://localhost:8080/actuator/health

### 4. Run Locally (Without Docker)

#### Backend

```bash
cd backend
mvn clean install
mvn spring-boot:run
```

#### Frontend

```bash
cd frontend
npm install
npm run dev
```

---

## 🧪 Testing

### Backend Tests

```bash
cd backend
mvn test
```

### Frontend Tests

```bash
cd frontend
npm run test
```

---

## 📚 API Overview

| Method | Endpoint                        | Description                          | Auth Required |
|--------|---------------------------------|--------------------------------------|---------------|
| POST   | `/api/v1/auth/register`         | User registration                    | No            |
| POST   | `/api/v1/auth/login`            | Login + MFA                          | No            |
| POST   | `/api/v1/auth/refresh`          | Refresh access token                 | Yes (Refresh) |
| POST   | `/api/v1/auth/logout`           | Logout (current / all devices)       | Yes           |
| GET    | `/api/v1/dashboard/overview`    | Account balances & summary           | Yes           |
| GET    | `/api/v1/dashboard/transactions`| Transaction history + filters        | Yes           |
| GET    | `/api/v1/dashboard/insights`    | Spending insights & recommendations  | Yes           |
| POST   | `/api/v1/payments/initiate`     | Initiate a payment                   | Yes           |
| GET    | `/api/v1/payments/{id}/status`  | Check payment status                 | Yes           |
| GET    | `/api/v1/beneficiaries`         | List beneficiaries                   | Yes           |
| POST   | `/api/v1/beneficiaries`         | Add beneficiary                      | Yes           |

Full interactive documentation is available at `/swagger-ui.html` when the backend is running.

---

## 🗄 Database Schema (Core Tables)

- `users` – User accounts and profile data
- `user_devices` – Trusted devices and bindings
- `sessions` / `refresh_tokens` – Active sessions
- `accounts` – Bank accounts linked to users
- `transactions` – All financial transactions
- `payments` – Payment initiation and status records
- `beneficiaries` – Saved payment recipients
- `consents` – User consent and preference records
- `audit_logs` – Security and action audit trail

SQL initialization scripts are available in `scripts/init-db.sql` and `scripts/seed-data.sql`.

---

## 🔒 Security Highlights

- Passwords hashed with BCrypt
- JWT with short-lived access tokens + rotating refresh tokens
- Rate limiting on authentication endpoints
- Input validation and sanitization
- CORS restricted to configured frontend origin
- Sensitive data encrypted at rest (where applicable)
- Comprehensive audit logging

> **Note**: This is a portfolio / demonstration project. Do **not** use it with real customer data or real money without additional hardening, penetration testing, and compliance reviews.

---

## 📦 Deployment

### Quick Deploy Options

| Component   | Recommended Platform      | Notes                              |
|-------------|---------------------------|------------------------------------|
| Frontend    | Vercel / Netlify          | Connect GitHub repo                |
| Backend     | Railway / Render / Fly.io | Deploy via Dockerfile              |
| Database    | Neon / Supabase / Railway | Managed PostgreSQL                 |
| Redis       | Upstash / Railway         | Serverless Redis                   |

See the `docs/` folder for additional deployment guidance.

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

Please follow the existing coding standards and add appropriate tests.

---

## 📄 License

This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Utkarsh Manoj Patil**  
Aspiring Application Engineer | Digital Banking & Full-Stack Development

- Email: utkp17@gmail.com
- Location: Mumbai, Maharashtra
- LinkedIn: [UTkp17]
- GitHub: [utkp17-omegavoid]

---

## 🙏 Acknowledgements

- Inspired by real-world digital banking platforms and RBI guidelines for secure digital payments.
- Built as a portfolio project to demonstrate end-to-end application engineering skills.

---

**⭐ If you find this project useful, please give it a star on GitHub!**
