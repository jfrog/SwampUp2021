const express = require('express');
const path = require('path');
const morgan = require('morgan');
const bodyParser = require('body-parser');

const app = express()
const port = 3000

app.use(morgan('tiny'))

app.get('/', (req, res) => {
    res.send(`🐸 Welcome to SWAMPUP-2021 🐸`)
})

app.get('/session', (req, res) => {
    res.send(`🐸 SU-201 Intro to DevSecOps with JFrog Xray 🐸`)
})

app.use((req, res, next) => {
    const error = new Error("Not found");
    error.status = 404;
    error.message = "🐸 Ribbit Ribbit Ribbit Ribbit 🐸"
    next(error);
});

// error handler middleware
app.use((error, req, res, next) => {
    res.status(error.status || 500).send({
      error: {
        status: error.status || 500,
        message: error.message || 'Internal Server Error',
      },
    });
  });

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})