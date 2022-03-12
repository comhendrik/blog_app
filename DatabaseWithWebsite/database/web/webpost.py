from database.db import get_db, query_db

from flask import *

bp = Blueprint("webpost",__name__, url_prefix="/web/post")

#access from web

@bp.route('/create_post',methods=['GET','POST'])
def create_Post():
    #Erstelle einen Post mit Nutzernamen, Title und body.
    if request.method == 'POST':
        if g.user:
            username = g.user['username']
            title = request.form.get('title')
            body = request.form.get('body')    
            # get_db() aus ../db.py öffnet die Datenbank
            # #Falls alle Bedingungen im POST Request enthalten sind wird versucht einen Post zu erstellen.  
            if not title or not body:
                flash("problems at creation")
                return redirect('create_post')
            
            db = get_db()
            cursor = db.cursor()
            #insert data into sqlite database
            try: 
                cursor.execute(f"INSERT INTO post (user, title, body) VALUES ('{username}', '{title}', '{body}')")
                db.commit()
                db.close()
            except db.IntegrityError:
                #Gelignt die Erstellung nicht wird ein Error zurückgegeben
                flash("Problem with uploading post")
                db.close()
                return redirect('create_post')
            else:
                #Gelingt die Erstellung wird der Nutzer zur homepage gebracht.
                return redirect('home')
        flash("Please login")

        return redirect('create_post')
    return render_template('posts/create.html')

@bp.route('/home', methods=['GET'])
def get_Posts():
    #Diese Funktion holt sich alle Posts und übergibt diese, nach id sortiert, and die gerendert blogpage.
    db = get_db()
    cursor = db.cursor()
    results = query_db("SELECT * FROM post", cursor=cursor)
    results = sorted(results, key=lambda d: d['id'], reverse=True)
    return render_template("posts/blog.html", posts=results)