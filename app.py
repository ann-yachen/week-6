from flask import Flask, request, render_template, redirect, session
import mysql.connector
import os # for secret key

cnx = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '12345678',
    database = 'website'
)
cursor = cnx.cursor()

# Create Application object
# "public" folder and "/" path for static files
app = Flask(__name__, static_folder = "public", static_url_path = "/")
app.secret_key = os.urandom(16) # generate random string for secret key

# Request-1
# Handle route "/" as homepage
@app.route("/")
def index():
    return render_template("index.html")

# Request-2
# Handle route "/signup" to create an account
@app.route("/signup", methods = ["POST"])
def signup():
    # Get name, username and password from form by POST
    name = request.form.get("name")
    username = request.form.get("username")
    password = request.form.get("password")  
    # Check if member exists using MySQL: cursor.execute(operation, params=None, multi=False)
    cursor.execute("SELECT * FROM member WHERE username=%s", (username,)) # params need to be a dict or tuple
    # Fetch one record and return
    check_member_exists = cursor.fetchone()
    if check_member_exists:
        return redirect("/error?message=帳號已經被註冊") # Redirect to /error with query string
    else:
        # Create record in table "member" in database
        cursor.execute("INSERT INTO member(name, username, password) VALUES(%s, %s, %s)", (name, username, password))
        cnx.commit()
        return redirect("/")

# Request-3
# Handle "/signin" to sign in
@app.route("/signin", methods = ["POST"])
def signin():
    # Get username and password from form by POST
    username = request.form.get("username")
    password = request.form.get("password")
    # Check if member exists using MySQL
    cursor.execute("SELECT * FROM member WHERE username=%s AND password=%s", (username, password,))
    member = cursor.fetchone() # return a tuple (id, name, username, password)
    # If member exists in table "member" in database
    if member:
        # Create session
        session["signedin"] = True
        session["id"] = member[0] # id
        session["name"] = member[1] # name
        session["username"] = member[2] # username
        return redirect("/member")
    else:
        # Member doesn't exist or incorrect username/password, redirect to error page
        return redirect("/error?message=帳號或密碼輸入錯誤") # Redirect to /error with query string

# Request-4
# Handle "/signout" to sign out
@app.route("/signout")
def signout():
    # Remove session data, sign out
    session.pop("signedin", None)
    session.pop("id", None)
    session.pop("username", None)
    session.pop("name", None)
    return redirect("/")

@app.route("/member")
def member():
    # Check if user is signedin
    if "signedin" in session:
        return render_template("member.html", name = session["name"]) # show name in member page
    else:
        return redirect("/")

@app.route("/error")
def error():
    # Get query string of message
    message = request.args.get("message") 
    # Show message in error page
    return render_template("error.html", message = message)

app.run(port = 3000)
