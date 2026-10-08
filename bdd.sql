-- ----------------------------------------------------------
-- Script MYSQL pour mcd 
-- ----------------------------------------------------------


-- ----------------------------
-- Table: categorie
-- ----------------------------
CREATE TABLE categorie (
  id_categorie INT NOT NULL AUTO_INCREMENT,
  libelle VARCHAR(50) NOT NULL,
  CONSTRAINT categorie_PK PRIMARY KEY (id_categorie),
  CONSTRAINT libelle_UNQ UNIQUE (libelle)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: utilisateur
-- ----------------------------
CREATE TABLE utilisateur (
  id_utilisateur INT NOT NULL AUTO_INCREMENT,
  nom VARCHAR(50) NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  mot_de_passe VARCHAR(255) NOT NULL,
  role ENUM('utilisateur','admin') NOT NULL DEFAULT 'UTILISATEUR',
  CONSTRAINT utilisateur_PK PRIMARY KEY (id_utilisateur),
  CONSTRAINT email_UNQ UNIQUE (email)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: materiel
-- ----------------------------
CREATE TABLE materiel (
  id_materiel INT NOT NULL AUTO_INCREMENT,
  libelle VARCHAR(100) NOT NULL,
  description TEXT,
  quantite INT NOT NULL DEFAULT 0,
  id_categorie INT NOT NULL,
  CONSTRAINT materiel_PK PRIMARY KEY (id_materiel),
  CONSTRAINT materiel_id_categorie_FK FOREIGN KEY (id_categorie) REFERENCES categorie (id_categorie)
)ENGINE=InnoDB;


-- ----------------------------
-- Table: inventaire
-- ----------------------------
CREATE TABLE inventaire (
  id_inventaire INT NOT NULL AUTO_INCREMENT,
  date_inventaire DATE NOT NULL,
  id_utilisateur INT NOT NULL,
  CONSTRAINT inventaire_PK PRIMARY KEY (id_inventaire),
  CONSTRAINT inventaire_id_utilisateur_FK FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur)
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


-- ----------------------------
-- Table: demande_emprunt
-- ----------------------------
CREATE TABLE demande_emprunt (
  id_demande INT NOT NULL AUTO_INCREMENT,
  quantite INT NOT NULL,
  date_demande DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  date_retour_prevue DATE NOT NULL,
  statut ENUM('en_attente','validee','refusee','rendue') NOT NULL DEFAULT 'EN_ATTENTE',
  id_utilisateur INT NOT NULL,
  id_materiel INT NOT NULL,
  CONSTRAINT demande_emprunt_PK PRIMARY KEY (id_demande),
  CONSTRAINT demande_emprunt_id_utilisateur_FK FOREIGN KEY (id_utilisateur) REFERENCES utilisateur (id_utilisateur),
  CONSTRAINT demande_emprunt_id_materiel_FK FOREIGN KEY (id_materiel) REFERENCES materiel (id_materiel)
)ENGINE=InnoDB;

