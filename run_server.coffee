
express = require "express"
app = express.createServer()

# Path to our public directory
pub = __dirname + '/public';

app.configure ->
    app.use express.profiler()
    app.set "view engine", "jade"
    app.use express.compiler src: pub, enable: ['sass']
    #app.use express.logger()
    app.use express.favicon()
    app.use express.methodOverride()
    app.use express.bodyParser()
    app.use app.router

# Development Settings
app.configure 'development', ->
    console.log "Development Server"
    app.use express.static pub
    app.use express.errorHandler dumpExceptions: true, showStack: true

# Production Settings
app.configure 'production', ->
    console.log "Production Server"
    oneYear = 31557600000;
    app.use express.static pub, maxAge: oneYear
    app.use express.errorHandler()

app.get '/', (req, res) ->
	res.render "index"

# Start Server on Port 3000
app.listen 3000

