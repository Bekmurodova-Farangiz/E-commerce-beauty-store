from flask import Flask, render_template, request, redirect, url_for, session, flash
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector
from functools import wraps
import os
from werkzeug.utils import secure_filename


app = Flask(__name__)
app.secret_key = "secret-key-change-later"

DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "",
    "database": "wp9_ecommerce"
}
UPLOAD_FOLDER = "static/uploads"
ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "webp"}

def allowed_file(filename):
    return "." in filename and filename.rsplit(".", 1)[1].lower() in ALLOWED_EXTENSIONS


app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER


def get_db():
    return mysql.connector.connect(**DB_CONFIG)

def login_required(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        if "user_id" not in session:
            return redirect(url_for("login"))
        return fn(*args, **kwargs)
    return wrapper

def admin_required(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        if session.get("role") != "admin":
            flash("Admin access required")
            return redirect(url_for("products"))
        return fn(*args, **kwargs)
    return wrapper
@app.route("/home")
def landing():
    return render_template("home.html")

@app.route("/")
def home():
    # Always show the marketing/landing page first
    return redirect(url_for("landing"))

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"]
        email = request.form["email"]
        password = request.form["password"]

        password_hash = generate_password_hash(password)

        try:
            db = get_db()
            cur = db.cursor()
            cur.execute(
                "INSERT INTO users (username, email, password_hash, role) VALUES (%s,%s,%s,%s)",
                (username, email, password_hash, "user")
            )
            db.commit()
            cur.close()
            db.close()
        except:
            flash("Email already exists")
            return redirect(url_for("register"))

        flash("Registration successful")
        return redirect(url_for("login"))

    return render_template("register.html")

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]

        db = get_db()
        cur = db.cursor(dictionary=True)
        cur.execute("SELECT * FROM users WHERE email=%s", (email,))
        user = cur.fetchone()
        cur.close()
        db.close()

        if user and check_password_hash(user["password_hash"], password):
            session["user_id"] = user["id"]
            session["username"] = user["username"]
            session["role"] = user["role"]
            return redirect(url_for("products"))

        flash("Invalid email or password")

    return render_template("login.html")

@app.route("/logout")
def logout():
    session.clear()
    return redirect(url_for("login"))

@app.route("/search")
@login_required
def search():
    q = request.args.get("q", "").strip()
    category = request.args.get("category", "").strip()

    db = get_db()
    cur = db.cursor(dictionary=True)

    sql = "SELECT * FROM products WHERE 1=1"
    params = []

    if q:
        sql += " AND (name LIKE %s OR description LIKE %s OR category LIKE %s)"
        like = f"%{q}%"
        params.extend([like, like, like])

    if category:
        sql += " AND category = %s"
        params.append(category)

    sql += " ORDER BY id DESC"

    cur.execute(sql, tuple(params))
    products = cur.fetchall()

    # categories for dropdown
    cur.execute("SELECT DISTINCT category FROM products ORDER BY category ASC")
    categories = [row["category"] for row in cur.fetchall()]

    cur.close()
    db.close()

    return render_template("search.html", products=products, q=q, category=category, categories=categories)


@app.route("/products")
@login_required
def products():
    q = request.args.get("q", "").strip()
    category = request.args.get("category", "").strip()

    db = get_db()
    cur = db.cursor(dictionary=True)

    sql = "SELECT * FROM products WHERE 1=1"
    params = []

    if q:
        sql += " AND (name LIKE %s OR description LIKE %s OR category LIKE %s)"
        like = f"%{q}%"
        params.extend([like, like, like])

    if category:
        sql += " AND category = %s"
        params.append(category)

    sql += " ORDER BY id DESC"

    cur.execute(sql, tuple(params))
    products = cur.fetchall()

    # categories for dropdown
    cur.execute("SELECT DISTINCT category FROM products ORDER BY category ASC")
    categories = [row["category"] for row in cur.fetchall()]

    cur.close()
    db.close()

    return render_template("products.html", products=products, q=q, category=category, categories=categories)


def _get_ids_from_session(key):
    ids = session.get(key, [])
    if not isinstance(ids, list):
        ids = []
    return ids


def _add_id_to_session_list(key, product_id):
    ids = _get_ids_from_session(key)
    if product_id not in ids:
        ids.append(product_id)
    session[key] = ids


def _remove_id_from_session_list(key, product_id):
    ids = _get_ids_from_session(key)
    if product_id in ids:
        ids.remove(product_id)
    session[key] = ids


@app.route("/products/<int:product_id>/like", methods=["POST"])
@login_required
def like_product(product_id):
    _add_id_to_session_list("liked_items", product_id)
    flash("Product added to your liked items")
    return redirect(request.referrer or url_for("products"))


@app.route("/liked")
@login_required
def liked_items():
    liked_ids = _get_ids_from_session("liked_items")
    products = []
    if liked_ids:
        placeholders = ",".join(["%s"] * len(liked_ids))
        db = get_db()
        cur = db.cursor(dictionary=True)
        cur.execute(f"SELECT * FROM products WHERE id IN ({placeholders}) ORDER BY id DESC", tuple(liked_ids))
        products = cur.fetchall()
        cur.close()
        db.close()
    return render_template("liked.html", products=products)


@app.route("/products/<int:product_id>/unlike", methods=["POST"])
@login_required
def unlike_product(product_id):
    _remove_id_from_session_list("liked_items", product_id)
    flash("Product removed from your liked items")
    return redirect(request.referrer or url_for("liked_items"))


@app.route("/products/<int:product_id>/bucket", methods=["POST"])
@login_required
def add_to_bucket(product_id):
    _add_id_to_session_list("bucket", product_id)
    flash("Product added to your bucket")
    return redirect(request.referrer or url_for("products"))


@app.route("/bucket")
@login_required
def bucket():
    bucket_ids = _get_ids_from_session("bucket")
    products = []
    total = 0
    if bucket_ids:
        placeholders = ",".join(["%s"] * len(bucket_ids))
        db = get_db()
        cur = db.cursor(dictionary=True)
        cur.execute(f"SELECT * FROM products WHERE id IN ({placeholders}) ORDER BY id DESC", tuple(bucket_ids))
        products = cur.fetchall()
        total = sum(float(p["price"]) for p in products)
        cur.close()
        db.close()
    return render_template("bucket.html", products=products, total=total)


@app.route("/products/<int:product_id>/remove-from-bucket", methods=["POST"])
@login_required
def remove_from_bucket(product_id):
    _remove_id_from_session_list("bucket", product_id)
    flash("Product removed from your bucket")
    return redirect(request.referrer or url_for("bucket"))


@app.route("/purchase", methods=["GET", "POST"])
@login_required
def purchase():
    bucket_ids = _get_ids_from_session("bucket")
    if not bucket_ids:
        flash("Your bucket is empty")
        return redirect(url_for("products"))

    if request.method == "POST":
        name = request.form["name"]
        email = request.form["email"]
        address = request.form["address"]
        notes = request.form.get("notes", "")

        # Persist purchase info to a simple text log
        try:
            with open("orders.txt", "a", encoding="utf-8") as f:
                f.write(
                    f"User {session.get('user_id')} - {name} <{email}>\n"
                    f"Address: {address}\n"
                    f"Notes: {notes}\n"
                    f"Products: {bucket_ids}\n"
                    "------\n"
                )
        except Exception:
            pass

        session["bucket"] = []
        flash("Thank you for your purchase! We have received your order.")
        return redirect(url_for("products"))

    # GET: show purchase form
    bucket_ids = _get_ids_from_session("bucket")
    placeholders = ",".join(["%s"] * len(bucket_ids))
    db = get_db()
    cur = db.cursor(dictionary=True)
    cur.execute(f"SELECT * FROM products WHERE id IN ({placeholders})", tuple(bucket_ids))
    products = cur.fetchall()
    total = sum(float(p["price"]) for p in products)
    cur.close()
    db.close()

    return render_template("purchase.html", products=products, total=total)


@app.route("/admin")
@login_required
@admin_required
def admin():
    db = get_db()
    cur = db.cursor(dictionary=True)
    cur.execute("SELECT * FROM products ORDER BY id DESC")
    products = cur.fetchall()
    
    # Get categories for stats
    cur.execute("SELECT DISTINCT category FROM products ORDER BY category ASC")
    categories = [row["category"] for row in cur.fetchall()]
    
    cur.close()
    db.close()
    return render_template("admin.html", products=products, categories=categories)

@app.route("/admin/product/new", methods=["GET", "POST"])
@login_required
@admin_required
def product_new():
    if request.method == "POST":
        name = request.form["name"]
        description = request.form["description"]
        price = request.form["price"]
        category = request.form["category"]

        image_file = request.files.get("image")
        filename = None

        if image_file and allowed_file(image_file.filename):
            filename = secure_filename(image_file.filename)
            image_path = os.path.join(app.config["UPLOAD_FOLDER"], filename)
            image_file.save(image_path)

        db = get_db()
        cur = db.cursor()
        cur.execute(
            "INSERT INTO products (name, description, price, category, image_filename) VALUES (%s,%s,%s,%s,%s)",
            (name, description, price, category, filename)
        )
        db.commit()
        cur.close()
        db.close()

        return redirect(url_for("admin"))

    # Get all categories for dropdown
    db = get_db()
    cur = db.cursor(dictionary=True)
    cur.execute("SELECT DISTINCT category FROM products WHERE category IS NOT NULL AND category != '' ORDER BY category ASC")
    categories = [row["category"] for row in cur.fetchall()]
    cur.close()
    db.close()
    
    # Add default categories if none exist
    default_categories = ['Cleanser', 'Serum', 'Moisturizer', 'Sunscreen', 'Mask', 'Toner']
    for cat in default_categories:
        if cat not in categories:
            categories.append(cat)
    categories.sort()
    
    return render_template("product_form.html", product=None, categories=categories)

@app.route("/admin/product/<int:id>/edit", methods=["GET", "POST"])
@login_required
@admin_required
def product_edit(id):
    db = get_db()
    cur = db.cursor(dictionary=True)

    if request.method == "POST":
        name = request.form["name"]
        description = request.form["description"]
        price = request.form["price"]
        category = request.form["category"]

        image_file = request.files.get("image")
        filename = request.form.get("existing_image")

        if image_file and allowed_file(image_file.filename):
            filename = secure_filename(image_file.filename)
            image_path = os.path.join(app.config["UPLOAD_FOLDER"], filename)
            image_file.save(image_path)

        cur.execute(
            "UPDATE products SET name=%s, description=%s, price=%s, category=%s, image_filename=%s WHERE id=%s",
            (name, description, price, category, filename, id)
        )
        db.commit()
        cur.close()
        db.close()
        return redirect(url_for("admin"))

    cur.execute("SELECT * FROM products WHERE id=%s", (id,))
    product = cur.fetchone()
    
    # Get all categories for dropdown
    cur.execute("SELECT DISTINCT category FROM products WHERE category IS NOT NULL AND category != '' ORDER BY category ASC")
    categories = [row["category"] for row in cur.fetchall()]
    
    cur.close()
    db.close()
    
    # Add default categories if none exist
    default_categories = ['Cleanser', 'Serum', 'Moisturizer', 'Sunscreen', 'Mask', 'Toner']
    for cat in default_categories:
        if cat not in categories:
            categories.append(cat)
    categories.sort()
    
    return render_template("product_form.html", product=product, categories=categories)

@app.route("/admin/product/<int:id>/delete", methods=["POST"])
@login_required
@admin_required
def product_delete(id):
    db = get_db()
    cur = db.cursor()
    cur.execute("DELETE FROM products WHERE id=%s", (id,))
    db.commit()
    cur.close()
    db.close()
    return redirect(url_for("admin"))


@app.route("/admin/categories")
@login_required
@admin_required
def category_manage():
    db = get_db()
    cur = db.cursor(dictionary=True)
    
    # Get all distinct categories with product counts
    cur.execute("""
        SELECT category as name, COUNT(*) as product_count 
        FROM products 
        WHERE category IS NOT NULL AND category != ''
        GROUP BY category 
        ORDER BY category ASC
    """)
    categories = cur.fetchall()
    
    cur.close()
    db.close()
    return render_template("categories.html", categories=categories)


@app.route("/admin/category/add", methods=["POST"])
@login_required
@admin_required
def category_add():
    name = request.form.get("name", "").strip()
    if not name:
        flash("Category name is required")
        return redirect(url_for("category_manage"))
    
    # Categories are stored in products, so we just need to validate
    # The category will exist once a product uses it
    flash(f"Category '{name}' will be available when you create a product with it.")
    return redirect(url_for("category_manage"))


@app.route("/admin/category/<name>/edit")
@login_required
@admin_required
def category_edit(name):
    return render_template("category_edit.html", old_name=name)


@app.route("/admin/category/<old_name>/update", methods=["POST"])
@login_required
@admin_required
def category_update(old_name):
    new_name = request.form.get("name", "").strip()
    if not new_name:
        flash("Category name is required")
        return redirect(url_for("category_edit", name=old_name))
    
    if new_name == old_name:
        return redirect(url_for("category_manage"))
    
    db = get_db()
    cur = db.cursor()
    
    # Update all products with the old category name to the new name
    cur.execute("UPDATE products SET category = %s WHERE category = %s", (new_name, old_name))
    db.commit()
    
    cur.close()
    db.close()
    
    flash(f"Category '{old_name}' has been renamed to '{new_name}'")
    return redirect(url_for("category_manage"))


@app.route("/admin/category/<name>/delete", methods=["POST"])
@login_required
@admin_required
def category_delete(name):
    db = get_db()
    cur = db.cursor(dictionary=True)
    
    # Check if any products use this category
    cur.execute("SELECT COUNT(*) as count FROM products WHERE category = %s", (name,))
    result = cur.fetchone()
    
    if result["count"] > 0:
        flash(f"Cannot delete category '{name}' because it has {result['count']} product(s) assigned to it.")
        cur.close()
        db.close()
        return redirect(url_for("category_manage"))
    
    # If no products use it, the category doesn't really exist (it's just a distinct value)
    # So we can just redirect
    cur.close()
    db.close()
    flash(f"Category '{name}' has been removed (no products were using it)")
    return redirect(url_for("category_manage"))


if __name__ == "__main__":
    app.run(debug=True)



