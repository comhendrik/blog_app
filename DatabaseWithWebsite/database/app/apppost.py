from database.db import get_db, query_db
from flask import *


bp = Blueprint("apppost",__name__, url_prefix="/app/post")

#access from app

@bp.route('/create_post',methods=['POST'])
def create_Post():
    #Erstelle einen Post mit Nutzernamen, Title und body.
    username = request.json['username']
    title = request.json['title']
    body = request.json['body']
    db = get_db()
    cursor = db.cursor()
    error = None
    if not username:
        error = "Sign in to post"
    elif not title:
        error = "title required to post a blog article"
    elif not body:
        error = "body required to post a blog article"
    #Falls alle Bedingungen im POST Request enthalten sind wird versucht einen Post zu erstellen.
    if error == None:
        try: 
            cursor.execute(f"INSERT INTO post (user, title, body) VALUES ('{username}', '{title}', '{body}')")
            db.commit()
            post_id = cursor.lastrowid
            
        except db.IntegrityError:
            #Gelignt die Erstellung nicht wird ein Error zurückgegeben
            error = "Problem with uploading post"
        else:
            #Gelingt die Erstellung wird der Post als Dictionary zurückgegeben.
            data = {'username': f'{username}', 'title': f'{title}', 'body':f'{body}', 'post_id': f'{post_id}'}
            db.close()
            return json.dumps(data)
        
    return error

@bp.route('/all_post', methods=['GET'])
def get_Posts():
    #Diese Funktion versorgt die App mit allen Posts, da einfach alle Posts zurückgegeben werden.
    db = get_db()
    cursor = db.cursor()
    results = query_db("SELECT * FROM post", cursor=cursor)
    return json.dumps(results)