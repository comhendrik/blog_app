import functools
from database.db import query_db

from flask import Blueprint
from flask import flash
from flask import g
from flask import redirect
from flask import render_template
from flask import request
from flask import session

from database.db import get_db

bp = Blueprint("webauth", __name__, url_prefix="/web/auth")

@bp.before_app_request
def load_logged_in_user():
    """If a user id is stored in the session, load the user object from
    the database into ``g.user``."""
    user_id = session.get("user_id")

    if user_id is None:
        g.user = None
    else:
        g.user = (
            get_db().execute("SELECT * FROM user WHERE id = ?", (user_id,)).fetchone()
        )

@bp.route("/register", methods=("GET", "POST"))
def register():
    """
    Registrierung eines neuen Nutzers über die Website
    Erklärungen siehe ../app/appauth.py
    """
    #Da auf diese URL über die Website zugegriffen wird, kann es ein GET und POST request sein. Bei einem GET Request wollen wir die
    #Registerpage anzeigen. Andernfalls wird ein User erstellt
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        db = get_db()
        error = None

        if not username:
            error = "Username is required."
        elif not password:
            error = "Password is required."

        if error is None:
            try:
                cursor = db.cursor()
                cursor.execute(
                    "INSERT INTO user (username, password) VALUES (?, ?)",
                    (username, password),
                )
                db.commit()
                user_id = cursor.lastrowid
            except db.IntegrityError:
                error = f"User {username} is already registered."
            else:
                # Bei Erfolg wird eine Flash message auf der homepage angezeigt. 
                flash("Please login to post")
                return redirect("/web/post/home")
        flash(error)
        return render_template("auth/register.html")

    return render_template("auth/register.html")


@bp.route("/login", methods=("GET", "POST"))
def login():
    """
    Nutzer einloggen und id zur Session hinzufügen
    """
    #Da auf diese URL über die Website zugegriffen wird, kann es ein GET und POST request sein. Bei einem GET Request wollen wir die
    #Logingage anzeigen. Andernfalls wird ein User eingeloggt.
    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]
        db = get_db()
        error = None
        user = db.execute(
            "SELECT * FROM user WHERE username = ?", (username,)
        ).fetchone()

        if user is None:
            error = "no user with this username"
        elif not user["password"] == password:
            error = "Incorrect password."

        if error is None:
            #user id wird in der Session gespeichert und die Homepage wird angezeigt
            session.clear()
            user_id = user["id"]
            session["user_id"] = user_id
            return redirect("/web/post/home")
        #Bei einem Fehler wird erneut die Loginpage mit einer flash message angezeigt.
        flash(error)
        return render_template("auth/login.html")

    return render_template("auth/login.html")

@bp.route("/logout")
def logout():
    """
    Dadurch, dass die Session gelöscht wird und der Nutzer zurück zur Homepage geführt wird, wird der Nutzer ausgeloggt,
    """
    session.clear()
    return redirect("/web/post/home")
