from flask import Flask, request, render_template, redirect, session
import mysql.connector
import os # for secret key

cnx = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password = '12345678',
    database = 'website',
)
cursor = cnx.cursor(dictionary=True) # Set cursor which return dictionary, default is tuple

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
    member = cursor.fetchone() # return a dict {"id", "name", "username", "password"}
    # If member exists in table "member" in database
    if member:
        # Create session
        session["id"] = member["id"]
        session["name"] = member["name"]
        session["username"] = member["username"]
        return redirect("/member")
    else:
        # Member doesn't exist or incorrect username/password, redirect to error page
        return redirect("/error?message=帳號或密碼輸入錯誤") # Redirect to /error with query string

# Request-4
# Handle "/signout" to sign out
@app.route("/signout")
def signout():
    # Remove session data, sign out
    session.clear()
    return redirect("/")

# Handle "/member" for member page
@app.route("/member")
def member():
    # Check if user is signedin
    if "username" in session:
        # Get message content using SQL (for Request-5)
        cursor.execute("SELECT member_id, content, name FROM message INNER JOIN member ON message.member_id=member.id")
        messages = cursor.fetchall()
        return render_template("member.html", name = session["name"], messages = messages) # show name and messages in member page
    else:
        return redirect("/")

# Handle "/error" for inproper operation 
@app.route("/error")
def error():
    # Get query string of message
    message = request.args.get("message") 
    # Show message in error page
    return render_template("error.html", message = message)

# Request-5
# Handle "/message" for message from member
@app.route("/message", methods = ["POST"])
def message():
    # Get message content from form by POST
    content = request.form.get("content")
    # Create message record in "message" in database 
    cursor.execute("INSERT INTO message(member_id, content) VALUES(%s, %s)", (session["id"], content)) # Get id from session as member_id
    cnx.commit()
    return redirect("/member")

if __name__ == "__main__":
    app.run(port = 3000)
