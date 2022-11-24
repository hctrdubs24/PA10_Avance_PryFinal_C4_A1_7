const mysql = require("mysql2"),
  connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "pa10_avance_pryfinal_c4_a1_7",
    port: 3306,
  });

connection.connect((error) => {
  if (error) {
    console.log(`El error de conexión es: ${error}`);
    return;
  }
  console.log("Conectado a la base de datos");
});

module.exports = connection;
