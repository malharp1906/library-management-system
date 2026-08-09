# Library Management System

A modern full-stack web and mobile application for managing library books. The system is built with a **Flutter** frontend and a **Spring Boot** backend integrated with a **PostgreSQL** database.

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
- **Backend**: Spring Boot (Java 17/21/25) - REST API with JPA/Hibernate.
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
- [Java Development Kit (JDK)](https://adoptium.net/) (JDK 17 or higher)
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
   Navigate to `backend/src/main/resources/application.properties` and verify your PostgreSQL credentials:
   ```properties
   spring.datasource.url=jdbc:postgresql://localhost:5432/library_db
   spring.datasource.username=your_postgres_username
   spring.datasource.password=your_postgres_password
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
