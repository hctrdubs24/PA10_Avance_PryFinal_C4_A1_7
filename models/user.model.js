const connection = require("../database/db");

module.exports = {
  async listUsers(req, res) {
    connection.query(
      "SELECT musuario.CvUser, musuario.CvPerso, CONCAT(cnombre.DsNombre, ' ', p.DsApellid, ' ', m.DsApellid) AS 'Nombre',  musuario.NomUser, musuario.Contrasena, DATE_FORMAT(musuario.FechaIni,'%Y-%m-%d') as fechainicio, DATE_FORMAT(musuario.FechaFin,'%Y-%m-%d') as fechafin, musuario.EdoCta FROM musuario INNER JOIN mperso ON musuario.CvPerso = mperso.CvPerso  INNER JOIN cnombre on mperso.CvNombre = cnombre.CvNombre INNER JOIN capellid AS p on mperso.CvApePat = p.CvApellid INNER JOIN capellid AS m on mperso.CvApeMat = m.CvApellid",
      async (error, results) => {
        req.session.usersArray = results;
        try {
          res.render("users", {
            users: results,
            login: true,
            tipoPersona: req.session.tipoPersona,
          });
        } catch (error) {
          console.log(error);
        }
      }
    );
  },
  async selectUserToUpdate(req, res) {
    const CvUser = req.params.id;
    connection.query(
      "SELECT musuario.CvUser, CONCAT(cnombre.DsNombre, ' ', p.DsApellid, ' ', m.DsApellid) AS 'Nombre', musuario.CvPerso, musuario.NomUser, musuario.Contrasena, DATE_FORMAT(musuario.FechaIni,'%Y-%m-%d') as fechainicio, DATE_FORMAT(musuario.FechaFin,'%Y-%m-%d') as fechafin, musuario.EdoCta FROM musuario INNER JOIN mperso ON musuario.CvPerso = mperso.CvPerso INNER JOIN cnombre on mperso.CvNombre = cnombre.CvNombre INNER JOIN capellid AS p on mperso.CvApePat = p.CvApellid INNER JOIN capellid AS m on mperso.CvApeMat = m.CvApellid WHERE CvUser = ?",
      [CvUser],
      (error, results) => {
        try {
          res.render("edit", {
            login: true,
            tipoPersona: req.session.tipoPersona,
            userToUpdate: results[0],
          });
          // res.send({ user: results[0] });
        } catch (error) {
          console.log(error);
        }
      }
    );
  },
  async updateState(user) {
    connection.query(
      "UPDATE musuario SET EdoCta = '0' WHERE NomUser = ?",
      [user],
      async (error, results) => {
        return;
      }
    );
  },
  async login(user, password, req, res) {
    connection.query(
      "SELECT musuario.CvUser, musuario.CvPerso, musuario.NomUser, musuario.Contrasena, DATE_FORMAT(musuario.FechaIni,'%Y-%m-%d') as fechainicio, DATE_FORMAT(musuario.FechaFin,'%Y-%m-%d') as fechafin, musuario.EdoCta, mperso.CvTipoPerso FROM musuario INNER JOIN mperso ON mperso.CvPerso = musuario.CvPerso INNER JOIN ctipoperso ON ctipoperso.CvTipoPerso = mperso.CvTipoPerso WHERE musuario.NomUser = ?",
      [user],
      async (err, results) => {
        if (results.length == 0) {
          res.render("login", {
            alert: true,
            alertTitle: "Error",
            alertMessage: "El usuario no existe",
            alertIcon: "Error",
            showConfirmButton: true,
            timer: false,
            ruta: "login",
          });
        } else {
          if (results[0].EdoCta === 0) {
            res.render("login", {
              alert: true,
              alertTitle: "Error",
              alertMessage: "La cuenta se encuentra inactiva",
              alertIcon: "Error",
              showConfirmButton: true,
              timer: false,
              ruta: "login",
            });
          } else {
            let today = new Date(),
              dd = String(today.getDate()).padStart(2, "0"),
              mm = String(today.getMonth() + 1).padStart(2, "0"),
              yyyy = today.getFullYear();
            (today = `${yyyy}-${mm}-${dd}`),
              (todayCom = new Date(today)),
              (fechafinCom = new Date(results[0].fechafin)),
              (fechainiCom = new Date(results[0].fechainicio));

            if (fechainiCom <= todayCom && fechafinCom >= todayCom) {
              if (password != results[0].Contrasena) {
                res.render("login", {
                  alert: true,
                  alertTitle: "Error",
                  alertMessage: "Contrase??a incorrecta",
                  alertIcon: "Error",
                  showConfirmButton: true,
                  timer: false,
                  ruta: "login",
                });
              } else {
                req.session.loggedin = true;
                req.session.name = results[0].NomUser;
                req.session.password = results[0].Contrasena;
                req.session.tipoPersona = results[0].CvTipoPerso;
                res.render("login", {
                  alert: false,
                  alertTitle: "Conexi??n exitosa",
                  alertMessage: "Bienvenido al sistema",
                  alertIcon: "Success",
                  showConfirmButton: false,
                  timer: 1,
                  ruta: "",
                });
              }
            } else if (fechafinCom <= todayCom) {
              this.updateState(user);
              res.render("login", {
                alert: true,
                alertTitle: "Error",
                alertMessage:
                  "La cuenta ya alcanz?? el l??mite de tiempo de actividad",
                alertIcon: "Error",
                showConfirmButton: true,
                timer: false,
                ruta: "login",
              });
            } else if (fechainiCom >= todayCom) {
              res.render("login", {
                alert: true,
                alertTitle: "Error",
                alertMessage:
                  "La cuenta a??n no est?? activada, contacte al administrador",
                alertIcon: "Error",
                showConfirmButton: true,
                timer: false,
                ruta: "login",
              });
            }
          }
        }
      }
    );
  },
  async updatePassword(req, res, user, oldPassword, newPassword) {
    connection.query(
      "UPDATE musuario SET Contrasena = ? WHERE NomUser = ? AND Contrasena = ?",
      [newPassword, user, oldPassword],
      async (error, results) => {
        req.session.password = newPassword;
        res.render("password", {
          alert: true,
          alertTitle: "Actualizaci??n exitosa",
          alertMessage: "Actualizaci??n de la contrase??a realizada exitosamente",
          alertIcon: "Success",
          showConfirmButton: false,
          timer: 1500,
          ruta: "password",
          login: true,
          tipoPersona: req.session.tipoPersona,
          password: newPassword,
          name: req.session.user,
        });
      }
    );
  },
  async listCvPerson(req, res) {
    connection.query(
      "SELECT mperso.CvPerso, CONCAT(cnombre.DsNombre, ' ', p.DsApellid, ' ', m.DsApellid,  ' - ', ctipoperso.DsTipoPerso) AS 'Nombre'  FROM mperso INNER JOIN cnombre on mperso.CvNombre = cnombre.CvNombre INNER JOIN capellid AS p on mperso.CvApePat = p.CvApellid INNER JOIN capellid AS m on mperso.CvApeMat = m.CvApellid INNER JOIN ctipoperso on mperso.CvTipoPerso = ctipoperso.CvTipoPerso",
      async (error, results) => {
        try {
          req.session.cvperso = results;
          res.render("new", {
            login: true,
            tipoPersona: req.session.tipoPersona,
            cvperso: results,
            // todayDate: new Date(),
          });
        } catch (error) {
          console.log(error);
        }
      }
    );
  },
  async createNewUser(req, res, data) {
    connection.query(
      "INSERT INTO musuario (CvPerso, NomUser, Contrasena, FechaIni, FechaFin, EdoCta) VALUES (?,?,?,?,?,?)",
      [data[0], data[1], data[2], data[3], data[4], data[5]],
      async (error, results) => {
        try {
          res.render("new", {
            alert: true,
            alertTitle: "Creaci??n de usuarios",
            alertMessage: "El usuario se ha guardado exitosamente",
            alertIcon: "Success",
            showConfirmButton: false,
            timer: 1500,
            ruta: "users",
            login: true,
            tipoPersona: req.session.tipoPersona,
            cvperso: req.session.cvperso,
          });
        } catch (error) {
          console.log(error);
        }
      }
    );
  },
  async updateUser(req, res, data) {
    connection.query(
      "UPDATE musuario SET NomUser = ?, Contrasena = ?, FechaIni = ?, FechaFin = ?, EdoCta = ? WHERE CvUser = ?",
      [data[1], data[2], data[3], data[4], data[5], data[6]],
      async (error, results) => {
        try {
          res.render("edit", {
            alert: true,
            alertTitle: "Usuario actualizado",
            alertMessage: "El usuario se ha actualizado exitosamente",
            alertIcon: "Success",
            showConfirmButton: false,
            timer: 1500,
            ruta: "users",
            login: true,
            tipoPersona: req.session.tipoPersona,
            password: req.session.password,
            name: req.session.user,
            userToUpdate: req.session.userToUpdate,
          });
        } catch (error) {
          console.log(error);
        }
      }
    );
  },
  async deleteUser(req, res, id) {
    connection.query(
      "DELETE FROM musuario WHERE CvUser = ?",
      [id],
      async (error, results) => {
        try {
          res.render("users", {
            alert: true,
            alertTitle: "Error",
            alertMessage: "Usuario eliminado exitosamente",
            alertIcon: "Error",
            showConfirmButton: true,
            timer: false,
            ruta: "users",
            login: true,
            users: req.session.usersArray,
            tipoPersona: req.session.tipoPersona,
            password: req.session.password,
            name: req.session.user,
          });
        } catch (error) {
          console.log(error);
        }
      }
    );
  },
  async validateUserName(req, res, data, ruta) {
    connection.query(
      "SELECT NomUser FROM musuario WHERE NomUser = ?",
      [data[1]],
      async (error, results) => {
        try {
          if (results.length >= 1 && ruta === "new") {
            res.render("new", {
              alert: true,
              alertTitle: "Error",
              alertMessage: "El usuario ya existe",
              alertIcon: "Error",
              showConfirmButton: true,
              timer: false,
              ruta: "new",
              users: req.session.usersArray,
              password: req.session.password,
              name: req.session.user,
              login: true,
              tipoPersona: req.session.tipoPersona,
              cvperso: req.session.cvperso,
            });
          } else if (results.length >= 1 && ruta === "edit") {
            // res.render("edit", {
            //   alert: true,
            //   alertTitle: "Error",
            //   alertMessage: "El usuario ya existe",
            //   alertIcon: "Error",
            //   showConfirmButton: true,
            //   timer: false,
            //   ruta: `edit/${data[6]}`,
            //   login: true,
            //   tipoPersona: req.session.tipoPersona,
            //   password: req.session.password,
            //   name: req.session.user,
            //   userToUpdate: req.session.userToUpdate,
            // });
            this.updateUser(req, res, data);
          } else if (results.length == 0 && ruta === "edit") {
            this.updateUser(req, res, data);
          } else if (results.length == 0 && ruta === "new") {
            this.createNewUser(req, res, data);
          }
        } catch (error) {
          console.log(error);
        }
      }
    );
  },
};
