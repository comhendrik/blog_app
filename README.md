# blog_app
Description:
Blog app, which can be accessed from a website and via an API from a Swift Application. You can create an account , read and write posts. The database is managed by Flask and sqlite3 in Python.

Why I build this project:
Until this project I have always used Firebase as the backend for my iOS apps. I wanted to try something new and researched about building a database with Python and the Tutorial from flask was my starting point. Instead of just building the application from this tutorial, I tried to combine it with my own iOS app. I achieved my goal of creating my own Database and linking it to a Website and an iOS app so that both application are dealing with the same data.

Download:__
All commands are marked with ' '.__
1. Download it via Github and open the DatabaseWithWebsite Folder in your IDE
2. Create a Virtual Environment. It worked for me with python3 -m venv * (* is the name of your venv)
3. Activate the venv. It worked for me with '. */bin/activate'
4. Install Flask with 'pip install flask'
5. These commands are needed to run the server: 
    'export FLASK_APP=database'__
    'flask run'__
    Your Server is now running and you can access it on your localhost If you want to use it in production you need a production server.__
6.To Start the swift app you need to open the folder SwiftBlogApp in Xcode and press the build button.
More explanations are in the code.

Usecases:__
You can run this application on your own server and let other people signup and communicate with each other.

Credits:__
This tutorial from flask helped me a lot. You will recognize some lines of code from the tutorial ;)
https://flask.palletsprojects.com/en/2.0.x/tutorial/

This video from iOS Acedemy helped me to understand the functionality of POST Requests in Swift
https://www.youtube.com/watch?v=o3Rkg6WmZoY&t=497s
