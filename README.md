# Farangiz's Beauty — Skincare E-commerce Website

A premium beauty and skincare e-commerce web application developed for the Web Programming course exam.

This project simulates a modern online skincare store where customers can create accounts, browse products, manage shopping actions, and where an administrator can manage the catalog through a protected admin panel.

---

##  Main Features

###  User Features

- User registration and login
- Secure authentication with hashed passwords
- Browse skincare products
- View product images, prices, descriptions, and categories
- Wishlist / liked products
- Shopping cart functionality
- Order placement system

### Admin Features

- Protected administrator access
- Add new products
- Edit existing products
- Delete products
- Upload product images
- Manage available stock / product data

---

## Technologies Used

| Category | Technology |
|--------|------------|
| Backend | Python, Flask |
| Database | MySQL |
| Frontend | HTML5, CSS3, Jinja2 |
| Authentication | Flask Sessions |
| Styling | Custom CSS |
| Image Upload | static/uploads/ |
| Version Control | Git & GitHub |

---

## Project Structure

text wp9-ecommerce/ │── app.py │── requirements.txt │── wp9_ecommerce.sql │── README.md │ ├── templates/ │   ├── home.html │   ├── login.html │   ├── register.html │   ├── products.html │   ├── admin.html │   └── product_form.html │ ├── static/ │   ├── images/ │   ├── styles/ │   └── uploads/ │ └── docs/     ├── report.pages     └── screenshots/ 

---

##  How to Run Locally

### 1️ Create Virtual Environment

bash python3 -m venv venv source venv/bin/activate 

### 2️ Install Dependencies

bash pip install -r requirements.txt 

### 3️ Configure Database

Create a MySQL database named:

sql wp9_ecommerce 

Import the schema if needed:

bash wp9_ecommerce.sql 

### 4️ Run Application

bash python3 app.py 

### 5️ Open in Browser

text http://127.0.0.1:5000 

---

##  Admin Setup

1. Register a normal user account  
2. Open MySQL and run:

sql UPDATE users SET role = 'admin' WHERE email = 'YOUR_EMAIL'; 

3. Log out  
4. Log in again  
5. Access the admin panel

---

## Academic Goals of the Project

This project demonstrates understanding of:

- Full-stack web development fundamentals
- Flask routing and templating
- Database integration with MySQL
- Authentication and sessions
- CRUD operations
- Responsive front-end styling
- Project organization and version control

---

## Author

Farangiz Bekmurodova  
University Web Programming Project

---

## Note

This project was developed for educational purposes as part of a university
