const { Pool, Client } = require("pg");
const { readFileSync } = require("fs");
const { join } = require("path");

const connectionString = process.env.APP_POSTGRESQL_URI;
const caCertPath = join(__dirname, "..", "db_ca.crt");
const caCert = readFileSync(caCertPath);

(async () => {
  const pool = new Pool({
    connectionString: connectionString,
    ssl: {
      ca: caCert,
      rejectUnauthorized: true,
    },
  });

  const resBefore = await pool.query("SELECT * FROM users");
  console.info(resBefore.rows);

  pool.query("INSERT INTO users (name, email, age) VALUES ($1, $2, $3)", [
    "Arline Gordon",
    "arlinegordon@dognosis.com",
    29,
  ]);

  const resAfter = await pool.query("SELECT * FROM users");
  console.info(resAfter.rows);

  await pool.end();
})();
