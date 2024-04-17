const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");

const app = express();
var cors = require('cors');
app.use(cors());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/", (req, res) => {
  res.json({ message: "Welcome to Test API." });
});


const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database:"bus_management_system",
  port: 8889
});



let busLocation = { latitude: 0, longitude: 0 };

app.post("/updateLocation", (req, res) => {
  const { latitude, longitude } = req.body;
  busLocation = { latitude, longitude };
  res.json({ message: "Bus location updated successfully." });
});

app.get("/getBusLocation", (req, res) => {
  res.json(busLocation);
});

app.post('/signup', (req, res) => {
  const newUsers = req.body; // Assuming you are sending new user data in the request body

  // Check if the email or username already exists
  connection.query(
    `SELECT * FROM users WHERE email=? OR username=?`,
    [newUsers.email, newUsers.username],
    (err, results) => {
      if (err) {
        console.error('Error querying the database:', err);
        res.status(500).json({ error: 'Database error' });
        return;
      }

      if (results.length > 0) {
        res.status(400).json({ error: 'User already exists' });
        return;
      }

      // If email and username are unique, insert the new user
      connection.query(
        `INSERT INTO users SET id = NULL, email = ?, username = ?, password = ?, active = 1, blocked = 0, approved = 0, levelOfAccess = ?`,
        [newUsers.email, newUsers.username, newUsers.password, newUsers.levelOfAccess],
        (err, result) => {
          if (err) {
            console.error('Error inserting new user:', err);
            res.status(500).json({ error: 'Database error' });
            return;
          }

          const insertedUser = {
            user_id: result.insertId,
            email: newUsers.email,
            username: newUsers.username,
            password: newUsers.password,
            active: 1,
            blocked: 0,
            approved: 0,
            levelOfAccess: newUsers.levelOfAccess,
          };

          console.log('Created user:', insertedUser);
          res.status(201).json(insertedUser);
        }
      );
    }
  );
});

//All Locations
app.get("/locations", (req, res) => {
  const query = "SELECT * FROM locations";
  connection.query(query, (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).send("Error fetching locations");
    } else {
      res.json(results);
    }
  });
});


//All routes
app.get("/route", (req, res) => {
  const query = "SELECT * FROM route";
  connection.query(query, (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).send("Error fetching locations");
    } else {
      res.json(results);
    }
  });
});


app.get("/stoppoint/:routeId", (req, res) => {
  const routeId = req.params.routeId;

  let query = "SELECT * FROM stoppoint";
  
  if (routeId) {
    query += ` WHERE routeId = ${routeId}`;
  }

  connection.query(query, (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).send("Error fetching locations");
    } else {
      res.json(results);
    }
  });
});

app.post("/booking", (req, res) => {
  const { departId, destinationId, pickupDate, routeId } = req.body;

  console.log(departId)
  console.log(destinationId)
  console.log(pickupDate)
  console.log(pickupDate)
  const query = `INSERT INTO booking (routeId, locationId, destinationId, pickupdate) VALUES (${routeId}, ${departId}, ${destinationId}, '${pickupDate}')`;


  connection.query(query, (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).send("Error inserting booking");
    } else {
      res.status(201).json({ message: "Booking inserted successfully" });
    }
  });
});

app.get("/api/users", (req, res) => {
  const query = "SELECT * FROM users";
  connection.query(query, (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).send("Error fetching locations");
    } else {
      res.json(results);
    }
  });
});
app.put('/api/users/:id', (req, res) => {
  const userId = parseInt(req.params.id);
  const updatedUser = req.body;

  const query = 'UPDATE users SET email = ?, username = ?, password = ?, active = ?, blocked = ?, approved = ?, levelOfAccess = ? WHERE id = ?';
  const values = [
    updatedUser.email,
    updatedUser.username,
    updatedUser.password,
    updatedUser.active,
    updatedUser.blocked,
    updatedUser.approved,
    updatedUser.levelOfAccess,
    userId
  ];

  connection.query(query, values, (error, results) => {
    if (error) {
      console.error('Error updating user:', error);
      res.status(500).json({ error: 'Error updating user' });
    } else {
      res.json({ message: 'User updated successfully' });
    }
  });
});




app.delete('/api/users/:id', (req, res) => {
  const userId = parseInt(req.params.id);

  const query = 'DELETE FROM users WHERE id = ?';
  connection.query(query, [userId], (error, results) => {
    if (error) {
      console.error('Error deleting user:', error);
      res.status(500).json({ error: 'Error deleting user' });
    }else {
      res.json({ message: 'User not found' });
    }
  });
});

app.get("/api/predict", (req, res) => {
  const query = "SELECT * FROM booking";
  connection.query(query, (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).send("Error fetching locations");
    } else {
      res.json(results);
    }
  });
});

const PORT = process.env.PORT || 3477;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});
