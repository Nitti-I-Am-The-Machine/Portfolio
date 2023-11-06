SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO';

CREATE SCHEMA IF NOT EXISTS `Nominal` DEFAULT CHARACTER SET utf8 ;
USE `Nominal` ;

CREATE TABLE IF NOT EXISTS `Nominal`.`equipamento` (
  `idequipamento` INT NOT NULL AUTO_INCREMENT,
  `nome_equipamento` VARCHAR(45) NOT NULL,
  `marca_equipamento` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idequipamento`))
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Nominal`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nome_cliente` VARCHAR(45) NOT NULL,
  `cpf_cliente` VARCHAR(45) NOT NULL,
  `fone_cliente` VARCHAR(45) NOT NULL,
  `genero_cliente` VARCHAR(45) NOT NULL,
  `ativo_cliente` TINYINT NULL,
  `nasc_cliente` DATE NOT NULL,
  `idequipamento_cliente` INT NOT NULL,
  PRIMARY KEY (`idcliente`, `idequipamento_cliente`),
  UNIQUE INDEX `cpf_cliente_UNIQUE` (`cpf_cliente` ASC) VISIBLE,
  INDEX `fk_cliente_equipamento1_idx` (`idequipamento_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_cliente_equipamento1`
    FOREIGN KEY (`idequipamento_cliente`)
    REFERENCES `Nominal`.`equipamento` (`idequipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Nominal`.`tecnico` (
  `idtecnico` INT NOT NULL AUTO_INCREMENT,
  `nome_tecnico` VARCHAR(45) NOT NULL,
  `cpf_tecnico` VARCHAR(45) NOT NULL,
  `fone_tecnico` VARCHAR(45) NOT NULL,
  `genero_tecnico` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idtecnico`),
  UNIQUE INDEX `cpf_tecnico_UNIQUE` (`cpf_tecnico` ASC) VISIBLE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `Nominal`.`servico` (
  `idservico` INT NOT NULL AUTO_INCREMENT,
  `custo_servico` DECIMAL(10, 2) NOT NULL,
  `ativo_servico` TINYINT NULL,
  `quitado_servico` TINYINT NULL,
  `inicio_servico` DATE NOT NULL,
  `fim_servico` DATE NOT NULL,
  `idtecnico_servico` INT NOT NULL,
  `idcliente_servico` INT NOT NULL,
  `idequipamento_servico` INT NOT NULL,
  PRIMARY KEY (`idservico`, `idtecnico_servico`, `idcliente_servico`, `idequipamento_servico`),
  INDEX `fk_servico_tecnico_idx` (`idtecnico_servico` ASC) VISIBLE,
  INDEX `fk_servico_cliente1_idx` (`idcliente_servico` ASC) VISIBLE,
  INDEX `fk_servico_equipamento1_idx` (`idequipamento_servico` ASC) VISIBLE,
  CONSTRAINT `fk_servico_tecnico`
    FOREIGN KEY (`idtecnico_servico`)
    REFERENCES `Nominal`.`tecnico` (`idtecnico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_cliente1`
    FOREIGN KEY (`idcliente_servico`)
    REFERENCES `Nominal`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_equipamento1`
    FOREIGN KEY (`idequipamento_servico`)
    REFERENCES `Nominal`.`equipamento` (`idequipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO equipamento (nome_equipamento, marca_equipamento) 
VALUES ('Playstation 4', 'Sony'),
       ('Laptop Linux', 'Acer'),
	   ('Placa Mãe', 'EVGA');

INSERT INTO tecnico (nome_tecnico, cpf_tecnico, fone_tecnico, genero_tecnico)
VALUES ('Augusto Meneguetti', '24612350912', '48923410521', 'Homem'),
	   ('Laura Gonçalves', '62210340210', '48952511432', 'Mulher'),
	   ('Juliano Souza', '43780934901', '48985439234', 'Homem');

INSERT INTO cliente (nome_cliente, cpf_cliente, nasc_cliente, fone_cliente, ativo_cliente, genero_cliente, idequipamento_cliente)
VALUES ('Gabriel da Silva', '26556212324', '1995-05-20', '48994232145', 1, 'Homem', 1), 
	   ('Mariana Braga', '53149212351', '2002-08-10', '48982153421', 1, 'Mulher', 2),
	   ('Juscelino Alves Neto', '45403021402', '1952-05-07', '48921395545', 0, 'Homem', 3);

INSERT INTO servico (ativo_servico, custo_servico, inicio_servico, fim_servico, quitado_servico, idcliente_servico, idequipamento_servico, idtecnico_servico)
VALUES (1, 450.20, '2023-03-05', '2023-04-10', 0, 1, 1, 3),
	   (1, 500.00, '2023-05-02', '2023-05-04', 1, 2, 2, 2),
	   (0, 1250.50, '2023-02-10', '2023-02-20', 1, 3, 3, 1);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

