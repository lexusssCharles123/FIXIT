const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

// Middleware
app.use(bodyParser.json());
app.use(cors());

// MySQL Connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'lexus',
  port: 3306, // Default MySQL port in XAMPP
});

db.connect((err) => {
  if (err) {
    console.error('MySQL connection error:', err);
  } else {
    console.log('Connected to MySQL database');
  }
});

// API endpoint to handle form submission
app.post('/submitForm', (req, res) => {
  console.log('Received data:', req.body); // Log received data

  try {
    const { name, contract, remarks } = req.body;

    // Validate inputs
    if (!name || !contract || !remarks) {
      throw new Error('Missing required fields');
    }

    const sql = 'INSERT INTO pogi (name, contract, remarks) VALUES (?, ?, ?)';
    db.query(sql, [name, contract, remarks], (err, result) => {
      if (err) {
        console.error('MySQL error:', err);
        res.status(500).send('Internal Server Error');
      } else {
        console.log('Data inserted successfully:', result);
        res.status(200).send('Data inserted successfully');
      }
    });
  } catch (error) {
    console.error('Form submission error:', error.message);
    res.status(400).send('Bad Request');
  }
});

const PORT = process.env.PORT || 3000; // use environment variable or default to 3000
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
