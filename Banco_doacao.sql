DROP DATABASE Banco_doacao;

CREATE DATABASE Banco_doacao;

USE banco_doacao;

CREATE TABLE IF NOT EXISTS Pessoa (
   ID INT NOT NULL,
   CPF VARCHAR(14) NOT NULL,
   Nome VARCHAR(45) NOT NULL,
   Sexo VARCHAR(1) NOT NULL,
   Contato VARCHAR(45) NOT NULL,
   Data_nascimento DATE NOT NULL,
   PRIMARY KEY (ID),
  UNIQUE INDEX CPF_UNIQUE (CPF ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Endereco (
   ID INT NOT NULL,
   Rua VARCHAR(45) NOT NULL,
   Bairro VARCHAR(45) NOT NULL,
   Numero VARCHAR(8) NOT NULL,
   Cidade VARCHAR(45) NOT NULL,
   UF VARCHAR(2) NOT NULL,
   Pessoa_Id INT NOT NULL,
   PRIMARY KEY (ID),  
   FOREIGN KEY (Pessoa_Id)   REFERENCES Pessoa (Id)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Unidade_coleta (
   ID INT NOT NULL,
   Nome VARCHAR(45) NOT NULL,
   UF VARCHAR(2) NOT NULL,
   Cidade VARCHAR(45) NOT NULL,
   Capacidade_estoque VARCHAR(30),
  PRIMARY KEY (ID))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Funcionario (
   ID INT NOT NULL,
   Cargo VARCHAR(45) NOT NULL,
   Pessoa_ID INT NOT NULL,
   Unidade_coleta_ID INT NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY (Pessoa_ID)   REFERENCES Pessoa (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE,   
   FOREIGN KEY (Unidade_coleta_ID)   REFERENCES Unidade_coleta (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Equipe_medica (
   ID INT NOT NULL,
   Funcao VARCHAR(45) NOT NULL,
   Turno VARCHAR(45) NOT NULL,
   Funcionario_ID INT NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY (Funcionario_ID)   REFERENCES Funcionario (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Recepcionista (
   ID INT NOT NULL,
   Senha VARCHAR(20) NOT NULL,
   Email VARCHAR(45) NOT NULL,
   Turno VARCHAR(20) NOT NULL,
   Funcionario_ID INT NOT NULL,
   PRIMARY KEY (ID),     
   FOREIGN KEY (Funcionario_ID)   REFERENCES Funcionario (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Doador (
   ID INT NOT NULL,
   Tipo_sanguineo VARCHAR(4) NOT NULL,
   Historico_aptdao TINYINT(1) NOT NULL,
   Pessoa_Id INT NOT NULL,
   Recepcionista_ID INT NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY (Pessoa_Id)   REFERENCES Pessoa (Id)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
   FOREIGN KEY (Recepcionista_ID)   REFERENCES Recepcionista (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE
)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Agendamento (
   ID INT NOT NULL,
   Data DATE NOT NULL,
   Hora VARCHAR(45) NOT NULL,
   Local VARCHAR(45) NOT NULL,
   Status VARCHAR(45) NOT NULL,
   Observacoes VARCHAR(45) NOT NULL,
   Doador_ID INT NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY (Doador_ID)   REFERENCES Doador (ID)
   ON DELETE CASCADE
   ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Triagem (
   ID INT NOT NULL,
   Data DATE NOT NULL,
   Hora VARCHAR(45) NOT NULL,
   Resultado_aptdao BOOLEAN NOT NULL,
   Equipe_medica_ID INT NOT NULL,
   Doador_ID INT NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY (Equipe_medica_ID)   REFERENCES Equipe_medica (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
   FOREIGN KEY (Doador_ID)    REFERENCES Doador (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Doacao (
   ID INT NOT NULL,
   Data_coleta DATE NOT NULL,
   Vol_coletado VARCHAR(45) NOT NULL,
   Data_validade DATE NOT NULL,
   Doador_ID INT NOT NULL,
   Unidade_coleta_ID INT NOT NULL,
   Equipe_medica_ID INT NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY (Doador_ID)   REFERENCES Doador (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
   FOREIGN KEY (Unidade_coleta_ID)   REFERENCES Unidade_coleta (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
   FOREIGN KEY (Equipe_medica_ID)
   REFERENCES Equipe_medica (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Controle_estoque (
   ID INT NOT NULL,
   Registro_entrada VARCHAR(45) NOT NULL,
   Registro_saida VARCHAR(45) NOT NULL,
   Unidade_coleta_ID INT NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY (Unidade_coleta_ID)   REFERENCES Unidade_coleta (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Laboratorio (
   Id INT NOT NULL,
   Capacidade_analise VARCHAR(45) NOT NULL,
   Tipo_analise VARCHAR(50) NOT NULL,
   Unidade_coleta_ID INT NOT NULL,
   PRIMARY KEY (Id),
   FOREIGN KEY (Unidade_coleta_ID)   REFERENCES Unidade_coleta (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS Analise_sangue (
   ID INT NOT NULL,
   Data_analise DATE NOT NULL,
   Resultado VARCHAR(45) NOT NULL,
   Laboratorio_Id INT NOT NULL,
   Triagem_ID INT NOT NULL,
   PRIMARY KEY (ID),
   FOREIGN KEY (Laboratorio_Id)   REFERENCES Laboratorio (Id)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
   FOREIGN KEY (Triagem_ID)   REFERENCES Triagem (ID)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO Pessoa VALUES(1,'111.111.111-11','Eliseu Souza','M','94 91111-1111',"2002-02-15"), 
						   (2,'222.222.222-22','João Gomes','M','91 91111-1111',"2005-06-02"),
                           (3,'333.333.333-33','Lucas Ruan','M','92 91111-1111',"1998-01-30"),
                           (4,'444.444.444-44','Reginaldo Carvalho','M','84 91111-1111',"2008-12-03"),
                           (5,'555.555.555-55','Amaris Gonzales','M','33 91111-1111',"1995-10-09"),
                           (6,'666.666.666-66','Jorge Pinto','M','44 91111-1111',"1965-11-09"),
                           (7,'777.777.777-77','Douglas Dilva','M','55 91111-1111',"1975-07-09"),
                           (8,'888.888.888-88','Cristina Maria','F','66 91111-1111',"1985-02-09"),
                           (9,'999.999.999-99','Isabela Barros','F','76 91111-1111',"1999-02-10");

						                         
INSERT INTO Endereco VALUES(1,'Piaui','Conquista','65','Tucurui','PA',1), 
						   (2,'Maranhao','Getat','12','Breu','PA',2),
                           (3,'Bahia','Beira Rio','99','Tucuruí','PA',3),
                           (4,'Avenida A','São Francisco','62','Breu','PA',4),
                           (5,'Carajás','Vila Permanente','48','Tucuruí','PA',5),
                           (6,'Mato Grosso','Serra Azul','50','Tucuruí','PA',6),
                           (7,'Santa Maria','Vila Marabá','111','Vila Permanente','PA',7),
                           (8,'Colombo','Centro','658','Tucuruí','PA',8);
                           

INSERT INTO Unidade_coleta VALUES(1,'Hemopa','PA','Tucurui','40 Bolsas de sangue'), 
								 (2,'Hospital do Sangue','PA','Breu','30 Bolsas de sangue'),
								 (3,'Posto de Coleta','PA','Tucuruí','20 Bolsas de sangue');

INSERT INTO Funcionario VALUES(1,'Enfermeiro', 5, 1), 
							  (2,'Enfermeiro', 6, 1),
							  (3,'Médico', 7, 1),
                              (4,'Recepcionista', 8, 1),
                              (5,'Recepcionista', 9, 1);
                              
                           
INSERT INTO Equipe_medica VALUES(1,'Realizar coleta','Tarde', 1), 
								(2,'Auxiliar na coleta','Tarde', 2),
								(3,'Realizar Triagem','Tarde', 3);
                                
INSERT INTO Recepcionista VALUES(1,'11111111', 'cristina@hemopa.com','Tarde', 4), 
								(2,'22222222', 'isabela@hemopa.com','Tarde', 5);
								
INSERT INTO Doador VALUES(1,'O+',True, 1, 1), 
						   (2,'O-',True, 2, 1),
                           (3,'O+',True, 3, 2),
                           (4,'AB+',True, 4, 2);
                           
INSERT INTO Agendamento VALUES(1,"2023-07-04",'14:00', 'Hemopa', 'Agendado', 'Prioridade', 1),
						 (2,"2023-07-05",'14:30', 'Hemopa', 'Agendado', 'Prioridade', 2),
                         (3,"2023-07-05",'15:40', 'Hemopa', 'Agendado', 'Nenhuma', 3),
                         (4,"2023-07-06",'16:20', 'Hemopa', 'Agendado', 'Nenhuma', 4);

INSERT INTO Triagem VALUES(1,"2023-07-04",'14:10', True, 3, 1),
						 (2,"2023-07-05",'14:40', True, 3, 2),
                         (3,"2023-07-05",'15:50', True, 3, 3),
                         (4,"2023-07-06",'16:30', True, 3, 4);
                         
INSERT INTO Doacao VALUES(1,"2023-07-04",'1000 ml', '2023-08-04', 1, 1, 1),
						 (2,"2023-07-05",'1000 ml', '2023-08-04', 2, 1, 1),
                         (3,"2023-07-05",'1000 ml', '2023-08-04', 3, 1, 1),
                         (4,"2023-07-06",'1000 ml', '2023-08-04', 4, 1, 1);
                         
INSERT INTO Controle_estoque VALUES(1,'4 Bolsas ','5 Bolsas', 1),
						 (2,"8 Bolsas", '4 Bolsas', 2),
                         (3,"7 Bolsas", '4 Bolsas', 3);
                         
INSERT INTO Laboratorio VALUES(1,'100 por Dia ','Tipagem ABO e Rh', 1),
						 (2,'150 por Dia', 'Doença de Chagas, sífilis, HIV e HTLV', 2),
                         (3,'50 por Dia', 'Hepatites B e C', 3);
                         
INSERT INTO Analise_sangue VALUES(1,"2023-07-05", 'Nenhuma Restrição', 1, 1),
								 (2,"2023-07-05", 'Nenhuma Restrição', 1, 2),
								 (3,"2023-07-05", 'Nenhuma Restrição', 1, 3),
								 (4,"2023-07-05", 'Nenhuma Restrição', 1, 4);
                         
/*Trigger (gatilhos)*/

DELIMITER //
CREATE TRIGGER atualizar_aptdao
AFTER UPDATE ON Triagem
FOR EACH ROW
BEGIN
    IF NEW.Resultado_aptdao = true THEN
        UPDATE Doador SET Historico_aptdao = true WHERE Doador.ID = NEW.Doador_ID;
    ELSE
        UPDATE Doador SET Historico_aptdao = false WHERE Doador.ID = NEW.Doador_ID;
    END IF;
END
//
DELIMITER ;

/*Queries de Consultas*/
SELECT Pessoa.Nome, Doador.Tipo_sanguineo as 'Tipo Sanguineo', Endereco.Bairro, Endereco.Rua, Endereco.Numero, Endereco.Cidade, Endereco.UF
FROM Pessoa, Endereco, Doador
WHERE Doador.Tipo_sanguineo = 'O+' and Pessoa.ID = Doador.Pessoa_Id and Endereco.Pessoa_Id = Pessoa.ID;


SELECT Pessoa.Nome, Funcionario.Cargo, Endereco.Bairro, Endereco.Rua, Endereco.Numero, Endereco.Cidade, Endereco.UF, Unidade_coleta.Nome
FROM Pessoa, Funcionario, Endereco, Unidade_coleta 
WHERE Unidade_coleta.Nome = 'Hemopa' and Pessoa.ID = Funcionario.Pessoa_Id and Endereco.Pessoa_Id = Pessoa.ID;


SELECT Pessoa.Nome, Funcionario.Cargo, Unidade_coleta.Nome AS Unidade_Coleta, Equipe_medica.Turno
FROM Pessoa
JOIN Funcionario ON Pessoa.ID = Funcionario.Pessoa_ID
JOIN Equipe_medica ON Funcionario.ID = Equipe_medica.Funcionario_ID
JOIN Unidade_coleta ON Funcionario.Unidade_coleta_ID = Unidade_coleta.ID;


/*Views (VISTAS)*/
CREATE VIEW Tipo_O_positivo AS SELECT Pessoa.Nome, Doador.Tipo_sanguineo as 'Tipo Sanguineo', Endereco.Bairro, Endereco.Rua, Endereco.Numero, Endereco.Cidade, Endereco.UF
FROM Pessoa, Endereco, Doador
WHERE Doador.Tipo_sanguineo = 'O+' and Pessoa.ID = Doador.Pessoa_Id and Endereco.Pessoa_Id = Pessoa.ID;

