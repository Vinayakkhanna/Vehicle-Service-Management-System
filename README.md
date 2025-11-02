# 🚗 Vehicle Service Management System (DBMS Project)

---

## 📝 Project Overview

The **Vehicle Service Management System** is a **Database Management System (DBMS) project** designed to manage customer details, vehicle information, service records, and invoices for a vehicle service center.
It demonstrates practical implementation of **E–R modeling**, **Normalization (up to 3NF)**, and **SQL operations** (DDL, DML, DQL).

This project helps automate workshop operations — including **vehicle servicing, billing, and record tracking** — ensuring efficiency and data consistency.

---

## 🚀 Features

* **👤 Customer Management:** Add, update, and view customer records.
* **🚘 Vehicle Management:** Store details about each customer’s vehicle.
* **🧰 Service Records:** Log every vehicle service with date, mechanic, and cost.
* **💵 Billing & Invoices:** Automatically calculate and store service charges.
* **🔍 Reports:** Generate queries for service history, total revenue, or pending payments.
* **🔗 Relationships:** Enforced with **Primary and Foreign Keys** for referential integrity.

---

## ⚙️ Concepts Used

* **E–R Modeling** – Identify entities, attributes, and relationships.
* **Relational Schema Conversion** – Transform E–R model into tables.
* **Normalization (1NF → 3NF)** – Remove redundancy and maintain data consistency.
* **SQL Operations** – Use DDL, DML, and DQL queries for database interaction.
* **Constraints** – Apply `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `CHECK`, and `UNIQUE`.

---

## 💡 How It Works

1. The system stores **customers**, **vehicles**, **mechanics**, **services**, and **invoices** in relational tables.
2. Each service record links a vehicle, a customer, and a mechanic.
3. When a service is completed, a **bill/invoice** is generated automatically.
4. Users can retrieve data using **SELECT**, **JOIN**, **GROUP BY**, and **VIEW** queries.
5. The database design ensures integrity, efficiency, and easy scalability.

---

### 🧾 Example Queries

```sql
-- List all vehicles serviced by a particular mechanic
SELECT m.mechanic_name, v.vehicle_model, s.service_date
FROM mechanics m
JOIN services s ON m.mechanic_id = s.mechanic_id
JOIN vehicles v ON v.vehicle_id = s.vehicle_id
WHERE m.mechanic_name = 'Rahul Sharma';

-- Calculate total revenue generated
SELECT SUM(total_amount) AS Total_Revenue FROM invoices;

-- Create a view of customer service history
CREATE VIEW Customer_Service_History AS
SELECT c.customer_name, v.vehicle_model, s.service_date, s.service_type, s.cost
FROM customers c
JOIN vehicles v ON c.customer_id = v.customer_id
JOIN services s ON v.vehicle_id = s.vehicle_id;
```

---

## 🧩 Database Schema Overview

| Table Name    | Description                                            |
| ------------- | ------------------------------------------------------ |
| **Customers** | Stores customer details like name, phone, and address. |
| **Vehicles**  | Contains vehicle info linked to customers.             |
| **Mechanics** | Holds details of mechanics performing services.        |
| **Services**  | Records service date, type, cost, and mechanic.        |
| **Invoices**  | Manages total billing and payment details.             |

---

## 🧠 Learning Outcomes

* Understand and apply **DBMS design principles**.
* Perform **data normalization** up to 3NF.
* Use **SQL commands** for data storage, retrieval, and management.
* Create and manage **views** and **joins** for report generation.
* Build a **complete mini-project** demonstrating end-to-end database design.

---

## 🛠️ Technologies Used

* **Database:** MySQL / Oracle / PostgreSQL
* **Language:** SQL
* **Tools:** MySQL Workbench / phpMyAdmin / Oracle SQL Developer
* **Concepts:** E–R Modeling, Normalization, Constraints, Joins, Views

---

## 📚 Future Enhancements

* Integrate a **front-end interface** (HTML/PHP or Python Flask).
* Implement **role-based login** (Admin, Mechanic, Customer).
* Add **automated reminders** for vehicle servicing.
* Include **data analytics** for customer trends and performance metrics.

---

## 🏁 Conclusion

The **Vehicle Service Management System** simplifies workshop operations by organizing service data efficiently using relational database concepts.
It’s a complete mini-project showcasing the practical use of **E–R modeling**, **normalization**, and **SQL operations** — perfect for students learning **DBMS fundamentals** and real-world database design.

---

⭐ **If you found this project helpful, don’t forget to give it a star on GitHub!** ⭐
