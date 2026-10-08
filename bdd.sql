-- ----------------------------------------------------------
-- Script MYSQL pour mcd 
-- ----------------------------------------------------------


-- ----------------------------
-- Table: role
-- ----------------------------
CREATE TABLE role (
  id_role INT NOT NULL AUTO_INCREMENT,
  libelle VARCHAR(50) NOT NULL,
  CONSTRAINT role_PK PRIMARY KEY (id_role)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: categorie
-- ----------------------------
CREATE TABLE categorie (
  id_categorie INT NOT NULL AUTO_INCREMENT,
  libelle VARCHAR(60) NOT NULL,
  CONSTRAINT categorie_PK PRIMARY KEY (id_categorie)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: statut_demande
-- ----------------------------
CREATE TABLE statut_demande (
  id_statut INT NOT NULL AUTO_INCREMENT,
  libelle VARCHAR(50) NOT NULL,
  CONSTRAINT statut_demande_PK PRIMARY KEY (id_statut)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: salle
-- ----------------------------
CREATE TABLE salle (
  id_salle INT NOT NULL AUTO_INCREMENT,
  libelle VARCHAR(60) NOT NULL,
  CONSTRAINT salle_PK PRIMARY KEY (id_salle)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: etat
-- ----------------------------
CREATE TABLE etat (
  id_etat INT NOT NULL AUTO_INCREMENT,
  libelle VARCHAR(50) NOT NULL,
  CONSTRAINT etat_PK PRIMARY KEY (id_etat)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: materiel
-- ----------------------------
CREATE TABLE materiel (
  id_materiel INT NOT NULL AUTO_INCREMENT,
  numero_inventaire VARCHAR(10),
  libelle VARCHAR(150) NOT NULL,
  marque VARCHAR(80),
  reference VARCHAR(80),
  numero_serie VARCHAR(60),
  quantite INT NOT NULL DEFAULT 1,
  controle_veritas TINYINT(1) NOT NULL DEFAULT FALSE,
  date_controle DATE,
  remarque VARCHAR(255),
  id_categorie INT NOT NULL,
  id_salle INT,
  id_etat INT NOT NULL,
  CONSTRAINT materiel_PK PRIMARY KEY (id_materiel),
  CONSTRAINT materiel_id_categorie_FK FOREIGN KEY (id_categorie) REFERENCES categorie (id_categorie),
  CONSTRAINT materiel_id_salle_FK FOREIGN KEY (id_salle) REFERENCES salle (id_salle),
  CONSTRAINT materiel_id_etat_FK FOREIGN KEY (id_etat) REFERENCES etat (id_etat)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: utilisateur
-- ----------------------------
CREATE TABLE utilisateur (
  id_utilisateur INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(60) NOT NULL,
  prenom VARCHAR(60) NOT NULL,
  email VARCHAR(120) NOT NULL,
  mot_de_passe VARCHAR(255) NOT NULL,
  id_role INT NOT NULL,
  CONSTRAINT utilisateur_PK PRIMARY KEY (id_utilisateur),
  CONSTRAINT email_UNQ UNIQUE (email),
  CONSTRAINT utilisateur_id_role_FK FOREIGN KEY (id_role) REFERENCES role (id_role)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: inventaire
-- ----------------------------
CREATE TABLE inventaire (
  id_inventaire INT NOT NULL AUTO_INCREMENT,
  date_inventaire DATE NOT NULL,
  commentaire VARCHAR(255),
  id_utilisateur INT NOT NULL,
  CONSTRAINT inventaire_PK PRIMARY KEY (id_inventaire),
  CONSTRAINT inventaire_id_utilisateur_FK FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: demande
-- ----------------------------
CREATE TABLE demande (
  id_demande INT NOT NULL AUTO_INCREMENT,
  quantite INT NOT NULL DEFAULT 1,
  date_demande DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  date_debut DATE NOT NULL,
  date_fin DATE NOT NULL,
  id_utilisateur INT NOT NULL,
  id_materiel INT NOT NULL,
  id_statut INT NOT NULL,
  CONSTRAINT demande_PK PRIMARY KEY (id_demande),
  CONSTRAINT demande_id_utilisateur_FK FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur),
  CONSTRAINT demande_id_materiel_FK FOREIGN KEY (id_materiel) REFERENCES materiel (id_materiel),
  CONSTRAINT demande_id_statut_FK FOREIGN KEY (id_statut) REFERENCES statut_demande (id_statut)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: ligne_inventaire
-- ----------------------------
CREATE TABLE ligne_inventaire (
  id_materiel INT NOT NULL,
  id_inventaire INT NOT NULL,
  quantite_comptee INT NOT NULL,
  CONSTRAINT ligne_inventaire_PK PRIMARY KEY (id_materiel, id_inventaire),
  CONSTRAINT ligne_inventaire_id_materiel_FK FOREIGN KEY (id_materiel) REFERENCES materiel (id_materiel),
  CONSTRAINT ligne_inventaire_id_inventaire_FK FOREIGN KEY (id_inventaire) REFERENCES inventaire (id_inventaire)
)ENGINE=InnoDB;

