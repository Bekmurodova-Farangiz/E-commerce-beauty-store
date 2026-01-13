# Beautiful Skincare E-commerce Website

This project is an original **E-commerce platform** developed for the **Web Programming course exam**.

The application represents an online **beauty and skincare products store**, where users can register, log in, and browse products, while an administrator can manage the product catalog.

---

## Features

### User Features
- User registration and login
- Secure authentication with hashed passwords
- View skincare products with images, descriptions, prices, and categories

### Admin Features
- Administrator login
- Add new products
- Edit existing products
- Delete products
- Upload product images from the admin panel

---

## Technologies Used

- **Backend:** Python (Flask)
- **Database:** MySQL
- **Frontend:** HTML, CSS
- **Authentication:** Flask sessions
- **Image Upload:** Stored in `static/uploads`

---

## Project Structure

wp9-ecommerce/
├── app.py
├── requirements.txt
├── templates/
│ ├── home.html
│ ├── login.html
│ ├── register.html
│ ├── products.html
│ ├── admin.html
│ └── product_form.html
├── static/
│ ├── style.css
│ └── uploads/
├── README.md
└── report.pdf

---

## How to Run the Project Locally

### 1. Create and activate virtual environment
```bash
python3 -m venv venv
source venv/bin/activate
2. Install dependencies
pip install -r requirements.txt
3. Configure MySQL
Create a database named: wp9_ecommerce
Create required tables (users, products)
4. Run the application
python3 app.py
5. Open in browser
http://127.0.0.1:5000
Admin Setup
Register a normal user from the website
Change the user role to admin in MySQL:
UPDATE users SET role='admin' WHERE email='YOUR_EMAIL';
Log out and log in again to access the admin panel
Project Report
A detailed PDF report describing:
Project motivation
Technologies used
Development decisions
Screenshots of the final application
is included in the repository.

Author
Farangiz Bekmurodova
