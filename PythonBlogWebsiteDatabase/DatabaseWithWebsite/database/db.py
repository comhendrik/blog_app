import sqlite3

import click
from flask import current_app, g
from flask.cli import with_appcontext

#Diese Datei enthält alle Funktion, damit eine sqlite Datenbank geflegt wird.

def query_db(query, cursor, args=(), one=False):
    #Diese Funktion ermöglicht eine Ausgabe einer Anfrage der Datenbank in einem Dictionary 
    cur = cursor
    cur.execute(query, args)
    r = [dict((cur.description[i][0], value) \
               for i, value in enumerate(row)) for row in cur.fetchall()]
    cur.connection.close()
    return (r[0] if r else None) if one else r

def get_db():
    #Diese Funktion verbindet sich mit der Datenbank
    if 'db' not in g:
        #Wenn keine Datenbank in g(https://flask.palletsprojects.com/en/2.0.x/appcontext/) gespeichert ist,
        #wird die Datenbank verbunden und gespeichert.
        g.db = sqlite3.connect(
            current_app.config['DATABASE'],
            detect_types=sqlite3.PARSE_DECLTYPES
        )
        g.db.row_factory = sqlite3.Row
    #Andernfalls können wir die im g gespeicherte Datenbank zurückgeben
    return g.db


def close_db(e=None):
    #Diese Funktion schließt die Datenbank und löscht sie aus dem g.
    db = g.pop('db', None)

    if db is not None:
        db.close()

def init_db():
    #Diese Funktion verbindet sich mit der Datenbank und führt das sql script unter database/schema.sql aus.

    db = get_db()

    with current_app.open_resource('schema.sql') as f:
        db.executescript(f.read().decode('utf8'))

#Die folgende Funktion wird als über das Terminal ausführbaren Command gespeichert.
#Dieser Code in dieser Date sorgt dafür, dass der Command flask init-db ausführbar wird.:
#@click.command('init-db')
#@with_appcontext

#app.cli.add_command(init_db_command)

@click.command('init-db')
@with_appcontext
def init_db_command():
    #Existierende Daten werden gelöscht und neue Tabellen werden erstellt
    init_db()
    click.echo('Initialized the database.')

def init_app(app):
    #App wird gelöscht und mit dem init-db command initialisiert
    #Der Code in der Datei database/__init__.py Zeile 40 sorgt dafür, dass dies innerhalb der create_app Methode passiert:
    #from . import db
    #db.init_app(app)
    
    app.teardown_appcontext(close_db)
    app.cli.add_command(init_db_command)




