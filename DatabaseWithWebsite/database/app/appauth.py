from database.db import get_db
from flask import *
import json

bp = Blueprint("appauth",__name__, url_prefix="/app/auth")

#access from app


@bp.route("/register", methods=["POST"])
def register():
    """
    Registrierung eines neuen Nutzers per POST Request innerhalb einer app.
    """
    username = request.json["username"]
    password = request.json["password"]
    db = get_db()
    cur = db.cursor()
    error = None

    if not username:
        error = "Username is required."
    elif not password:
        error = "Password is required."
    #Wenn kein Passwort bzw. Nutzername gefunden wurde, wird der Fehler zurückgegeben. Die App verarbeitet diesen entsprechend.
    if error is None:
        try:
            #Der Nutzer wird in die Datenbank eingetragen
            cursor = db.cursor()
            cursor.execute(
                "INSERT INTO user (username, password) VALUES (?, ?)",
                (username, password),
            )
            db.commit()
            user_id = cursor.lastrowid
        except db.IntegrityError:
            # Der Nutzernmae ist vergeben, was den Fehler ausgelöst hat
            error = f"User {username} is already registered."
        else:
            #Das Hinzufügen war erfolgreich und für weitere Verwendungszwecke wird dieser als Dictionary an die App zurückgegeben
            db.close()
            return {"id":f"{user_id}","username":f"{username}","password":f"{password}"}
    db.close()
    return error


@bp.route("/login", methods=["POST"])
def login():
    """
    Einen Nutzer über die App einloggen.
    """
    username = request.json["username"]
    password = request.json["password"]
    db = get_db()
    error = None
    user = db.execute(
        "SELECT * FROM user WHERE username = ?", (username,)
    ).fetchone()
    #Es wird versucht von der Datenbank den Nutzer zu erhalten. Wenn kein Nutzer vorhanden ist, gibt es keinen Nutzer mit dem übergebenen
    #Namen. Falls das übergebene Passwort nicht dem des Nutzers entspricht wird ebenfalls ein Error aufgerufen.
    if user is None:
        error = "Incorrect username."
    elif not user["password"] == password:
        error = "Incorrect password."
    #Wenn es keinen Fehler gibt wird der Nutzer in Form eines Dictionarys zurückgegeben, ansonsten der Nutzer
    if error is None:
        return {"username":user["username"],"id":user["id"]}
        

    return error


