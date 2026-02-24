# Pharo Bookstore Management System

A desktop application developed in Pharo. This project serves as a comprehensive example of object-oriented design, role-based access control, and data serialization in a Pharo environment.

## Key Functionalities

### Authentication and Authorization
The system features a dual-access login gateway. Depending on the credentials entered, the application dynamically modifies the interface to grant appropriate permissions:
- Administrator Access: Enables full inventory control, including book creation, removal, and bulk stock adjustment.
- Guest Access: Provides a simplified customer interface focused on browsing and purchasing.

### Inventory Management
The administrator dashboard allows for real-time manipulation of the bookstore catalog. Features include:
- Input validation for book titles, authors, and pricing.
- Dynamic stock adjustments via interactive dialogs to add or remove specific quantities of books.
- Protection logic to prevent negative stock values.

### Shopping Cart and Checkout Flow
The customer interface utilizes a split-pane layout for a modern user experience:
- Live Inventory View: Browse available books and their current stock levels.
- Active Cart: A secondary table that tracks selected items, quantities, and individual subtotals.
- Automated Accounting: Real-time calculation of the total order value.
- Transaction Validation: A checkout process that verifies stock availability before finalizing the purchase and updating the database.

### Data Persistence
To ensure data is not lost between sessions, the application implements a persistence layer using STON (Smalltalk Object Notation). The system automatically handles:
- State restoration upon application startup.
- Incremental saves to a local file whenever the inventory state is modified or a transaction is completed.

## Technical Specifications

- Development Environment: Pharo 13
- User Interface: Spec2 Framework
- Data Format: STON (Local File System)
- Architecture: Model-Presenter Pattern

## Installation and Usage

1. Import the package into your Pharo image using the Iceberg tool.
2. Open a Playground and execute the following:

   BSLoginPresenter new open.

3. Default Credentials:
   - Administrator: admin / admin123
   - Guest: guest / guest123
