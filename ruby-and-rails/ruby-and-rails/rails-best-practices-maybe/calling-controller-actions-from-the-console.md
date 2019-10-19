# Calling Controller actions from the console

captured on 2015-09-17 Thu 10:35

Various answers here: [http://stackoverflow.com/questions/151030/how-do-i-call-controller-view-methods-from-the-console-in-rails/1161163\#1161163](http://stackoverflow.com/questions/151030/how-do-i-call-controller-view-methods-from-the-console-in-rails/1161163#1161163)

Essentially:

```text
app.get '/users' # index
app.post '/users' # create with post data

## Possibly:

app.post app.users_path(...data...)
```

Note: [http://stackoverflow.com/a/23899701/742446](http://stackoverflow.com/a/23899701/742446)

Still unknown to me:

* how to specify params and format of the request when you're sending form data \(does that work with the path thingie correctly?\)



