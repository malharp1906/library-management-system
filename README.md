# Library Management System

A full-stack application for managing a library's book inventory. A cross-platform **Flutter** client talks to a **Spring Boot** REST API backed by **PostgreSQL**.

![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-6DB33F?logo=springboot&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)

## Features

- Browse the full book inventory
- Add new books (title, author, ISBN)
- Delete books
- Full CRUD REST API (create, read, update, delete) with `201`/`404` status handling
- One Flutter codebase for web, Windows desktop, Android and iOS
- CORS enabled so the Flutter web app can call the API from a different port

## How it fits together

```
Flutter app  --HTTP/JSON-->  Controller  ->  Service  ->  Repository  ->  PostgreSQL
                             (Spring Boot, layered Controller-Service-Repository)
```

The backend follows a layered **Controller -> Service -> Repository** design with JPA/Hibernate, which keeps each layer small and testable.

---

## Repository Structure

This repository is set up as a monorepo containing both the frontend and backend:

```
library-management-system/
├── README.md             # Root documentation
├── .gitignore            # Unified gitignore
├── frontend/             # Flutter Frontend App
└── backend/              # Spring Boot REST API Backend
```

---

## Architecture & Technology Stack

- **Frontend**: Flutter (Dart) - supports Web, Windows Desktop, Android, and iOS.
- **Backend**: Spring Boot 4 (Java 25) - REST API with JPA/Hibernate.
- **Database**: PostgreSQL - stores inventory tables with auto-incrementing identity schemas.

---

## API Documentation

The backend exposes the following REST endpoints under the `/api/books` namespace:

| Method | Endpoint | Description | Request Body |
| :--- | :--- | :--- | :--- |
| **GET** | `/api/books/read` | Fetch all books in the inventory | None |
| **GET** | `/api/books/read/{id}` | Fetch details of a specific book by ID | None |
| **POST** | `/api/books/create` | Add a new book to the inventory | JSON Book (excluding ID) |
| **PUT** | `/api/books/update/{id}` | Update details of an existing book | JSON Book fields to update |
| **DELETE** | `/api/books/delete/{id}` | Delete a book by ID | None |

### Book JSON Schema
```json
{
  "title": "The Great Gatsby",
  "author": "F. Scott Fitzgerald",
  "isbn": "978-0-7432-7356-5"
}
```

---

## Local Setup Guide

### Prerequisites
Make sure you have the following installed on your local machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.19.0 or higher recommended)
- [Java Development Kit (JDK)](https://adoptium.net/) (JDK 25, as set in `backend/pom.xml`)
- [Maven](https://maven.apache.org/) (included via `./mvnw` wrapper in backend)
- [PostgreSQL](https://www.postgresql.org/download/) database server

---

### Part 1: Backend Setup (Spring Boot)

1. **Database Creation**:
   Open your PostgreSQL client (pSQL or pgAdmin) and create a database named `library_db`:
   ```sql
   CREATE DATABASE library_db;
   ```

2. **Configure Environment**:
   The app reads database settings from environment variables, so no credentials are stored in the repo.

   | Variable | Required | Default |
   | :--- | :--- | :--- |
   | `DB_PASSWORD` | yes | none |
   | `DB_USERNAME` | no | `postgres` |
   | `DB_URL` | no | `jdbc:postgresql://localhost:5432/library_db` |

   ```bash
   # macOS / Linux
   export DB_PASSWORD=your_postgres_password

   # Windows PowerShell
   $env:DB_PASSWORD = "your_postgres_password"
   ```

3. **Build & Run**:
   Open a terminal in the `backend/` directory and run:
   ```bash
   # On Windows
   ./mvnw.cmd spring-boot:run

   # On Linux/macOS
   ./mvnw spring-boot:run
   ```
   The backend service will start on `http://localhost:8080`.

---

### Part 2: Frontend Setup (Flutter)

1. **Get Dependencies**:
   Open a terminal in the `frontend/` directory and run:
   ```bash
   flutter pub get
   ```

2. **Run the App**:
   Run the frontend application in your target browser or desktop device:
   ```bash
   # Run in Chrome (Web)
   flutter run -d chrome

   # Run on Windows Desktop
   flutter run -d windows
   ```

---

## Development Notes

- **CORS Configuration**: The backend has `@CrossOrigin(origins = "*")` configured on `BookController.java` to support requests from the Flutter Web app running on different local dev ports.
- **Auto-Incrementing IDs**: The backend entity maps the primary key using `@GeneratedValue(strategy = GenerationType.IDENTITY)` which automatically generates IDs in PostgreSQL when a book is created by the frontend.

---

## Roadmap

- [ ] Update-book screen in the Flutter client (the `PUT` endpoint already exists)
- [ ] Search and filter
- [ ] Input validation and clearer error responses
- [ ] Unit and integration tests for the service layer
- [ ] Authentication
- [ ] Docker Compose for one-command startup

## License

[MIT](LICENSE)
