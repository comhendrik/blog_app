# blog_app
Description:<br/>
Blog app, which can be accessed from a website and via an API from a Swift Application. You can create an account , read and write posts. The database is managed by Flask and sqlite3 in Python.

Why I have built this project:<br/>
Until this project I have always used Firebase as the backend for my iOS apps. I wanted to try something new and researched about building a database with Python and the Tutorial from flask was my starting point. Instead of just building the application from this tutorial, I tried to combine it with my own iOS app. I achieved my goal of creating my own Database and linking it to a Website and an iOS app so that both application are dealing with the same data.


Images:<br/>
-Web:<br/>
<img src="/ExampleImages/WebHome.png" width="250" height="auto">
<img src="/ExampleImages/WebCreate.png" width="250" height="auto">
<img src="/ExampleImages/WebSignIn.png" width="250" height="auto">
<br/>
-App:<br/>
<img src="/ExampleImages/AppHome.png" width="140" height="auto">
<img src="/ExampleImages/AppCreate.png" width="140" height="auto">
<img src="/ExampleImages/AppSignIn.png" width="140" height="auto">
<img src="/ExampleImages/AppSuccesfullySignedIn.png" width="140" height="auto">



Download:<br/>
All commands are marked with ' '.<br/>
1. Download it via Github and open the DatabaseWithWebsite Folder in your IDE
2. Create a Virtual Environment. It worked for me with python3 -m venv * (* is the name of your venv)
3. Activate the venv. It worked for me with '. */bin/activate'
4. Install Flask with 'pip install flask'
5. These commands are needed to run the server: <br/> 'export FLASK_APP=database'<br/> 'flask init-db' <br/> 'flask run'<br/> Your Server is now running and you can access it on your localhost If you want to use it in production you need a production server.<br/>
6. To Start the swift app you need to open the folder SwiftBlogApp in Xcode and press the build button. When you want to use another server, you need to provide the correct url<br/>
More explanations are in the code.

Usecases:<br/>
You can run this application on your own server and let other people signup and communicate with each other.

Credits:<br/>
This tutorial from flask helped me a lot. You will recognize some lines of code from the tutorial ;)
https://flask.palletsprojects.com/en/2.0.x/tutorial/

This video from iOS Acedemy helped me to understand the functionality of POST Requests in Swift
https://www.youtube.com/watch?v=o3Rkg6WmZoY&t=497s
