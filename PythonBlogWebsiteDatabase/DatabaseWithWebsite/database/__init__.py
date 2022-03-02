import os

from flask import Flask, request, redirect

import json

#erstellt mit Hilfe des Flask Tutorials: https://flask.palletsprojects.com/en/2.0.x/tutorial/

def create_app():
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True, template_folder='web/templates', static_folder='web/static')
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'db.sqlite'),
    )

    # sicherstellen, dass der instance folder existiert und die db.sqlite Datei enthält
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    @app.route('/')
    def direct_Home():
        #Diese Funktion leitet den User weiter zur gewünschten Seite,
        #wenn nur die normale URL eingegeben wird. Im Falle eines Testservers ist dies: http://127.0.0.1:5000
        return redirect('/web/post/home')

    

    from . import db
    #Ermöglicht die Initialisierung der Datenbank
    db.init_app(app)

    #Die Blueprints der einzelnen Python Dateien müssen registriert werden, damit sie mit der App funktionieren.
    #Beispiel:
    # Anfang der Datei:
    #bp = Blueprint("apppost",__name__, url_prefix="/app/post")
    #Jetzt kann die Datei als Blueprint registriert werden:
    #from database.app import apppost
    #//database.app ist der Weg zu dem Ordner mit der Datei und apppost ist die Datei selber
    #Folgender Code kommt in diese Datei
    #app.register_blueprint(apppost.bp)
    #Nun kann man in einer anderen Datei den Code schreiben und mit dem prefix http://127.0.0.1:5000/app/post erreichbar.

    from database.app import appauth, apppost

    app.register_blueprint(appauth.bp)
    app.register_blueprint(apppost.bp)

    from database.web import webpost

    app.register_blueprint(webpost.bp)

    from database.web import webauth
     
    app.register_blueprint(webauth.bp)

    return app
    

