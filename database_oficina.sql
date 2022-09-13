SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER SCHEMA `mydb`  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `mydb`.`Mecanico` (
  `idMecanico` INT(11) NOT NULL,
  `Nome` VARCHAR(45) NULL DEFAULT NULL,
  `Endereco` VARCHAR(200) NULL DEFAULT NULL,
  `Especialidade` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idMecanico`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipe` (
  `idEquipe` INT(11) NOT NULL,
  `participantes` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Ordem_de_serviço` (
  `idOrdem_de_serviço` INT(11) NOT NULL,
  `data_emissao` DATE NULL DEFAULT NULL,
  `valor_total` FLOAT(11) NULL DEFAULT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `data_finalizacao` DATE NULL DEFAULT NULL,
  `idTipo_serviço` INT(11) NOT NULL,
  `idOrcamento` INT(11) NOT NULL,
  PRIMARY KEY (`idOrdem_de_serviço`, `idTipo_serviço`, `idOrcamento`),
  INDEX `fk_Ordem_de_serviço_Tipo_serviço1_idx` (`idTipo_serviço` ASC) VISIBLE,
  INDEX `fk_Ordem_de_serviço_valores_mao_de_obra1_idx` (`idOrcamento` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem_de_serviço_Tipo_serviço1`
    FOREIGN KEY (`idTipo_serviço`)
    REFERENCES `mydb`.`Tipo_serviço` (`idTipo_seviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem_de_serviço_valores_mao_de_obra1`
    FOREIGN KEY (`idOrcamento`)
    REFERENCES `mydb`.`valores_mao_de_obra` (`idOrcamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`valores_mao_de_obra` (
  `idOrcamento` INT(11) NOT NULL,
  `valor` FLOAT(11) NULL DEFAULT NULL,
  `tipo_servico` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idOrcamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT(11) NOT NULL,
  `Nome` VARCHAR(45) NULL DEFAULT NULL,
  `CPF` VARCHAR(11) NULL DEFAULT NULL,
  `Endereço` VARCHAR(200) NULL DEFAULT NULL,
  `Telefone` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Veiculo` (
  `idVeiculo` INT(11) NOT NULL,
  `Modelo` VARCHAR(45) NULL DEFAULT NULL,
  `Ano` VARCHAR(4) NULL DEFAULT NULL,
  `Cliente_idCliente` INT(11) NOT NULL,
  PRIMARY KEY (`idVeiculo`, `Cliente_idCliente`),
  INDEX `fk_Veiculo_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Peças` (
  `idPeças` INT(11) NOT NULL,
  `Nome` VARCHAR(45) NULL DEFAULT NULL,
  `Valor` FLOAT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idPeças`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Tipo_serviço` (
  `idTipo_seviço` INT(11) NOT NULL,
  `tipo_serviço` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipo_seviço`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Mecanico_possui_Equipe` (
  `Mecanico_idMecanico` INT(11) NOT NULL,
  `Equipe_idEquipe` INT(11) NOT NULL,
  PRIMARY KEY (`Mecanico_idMecanico`, `Equipe_idEquipe`),
  INDEX `fk_Mecanico_has_Equipe_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  INDEX `fk_Mecanico_has_Equipe_Mecanico1_idx` (`Mecanico_idMecanico` ASC) VISIBLE,
  CONSTRAINT `fk_Mecanico_has_Equipe_Mecanico1`
    FOREIGN KEY (`Mecanico_idMecanico`)
    REFERENCES `mydb`.`Mecanico` (`idMecanico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mecanico_has_Equipe_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Veiculo_possui_Equipe` (
  `idVeiculo` INT(11) NOT NULL,
  `idCliente` INT(11) NOT NULL,
  `idEquipe` INT(11) NOT NULL,
  PRIMARY KEY (`idVeiculo`, `idCliente`, `idEquipe`),
  INDEX `fk_Veiculo_has_Equipe_Equipe1_idx` (`idEquipe` ASC) VISIBLE,
  INDEX `fk_Veiculo_has_Equipe_Veiculo1_idx` (`idVeiculo` ASC, `idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Veiculo_has_Equipe_Veiculo1`
    FOREIGN KEY (`idVeiculo` , `idCliente`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Veiculo_has_Equipe_Equipe1`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipe_possui_Ordem_de_serviço` (
  `idEquipe` INT(11) NOT NULL,
  `idOrdem_de_serviço` INT(11) NOT NULL,
  `idTipo_serviço` INT(11) NOT NULL,
  PRIMARY KEY (`idEquipe`, `idOrdem_de_serviço`, `idTipo_serviço`),
  INDEX `fk_Equipe_has_Ordem_de_serviço_Ordem_de_serviço1_idx` (`idOrdem_de_serviço` ASC, `idTipo_serviço` ASC) VISIBLE,
  INDEX `fk_Equipe_has_Ordem_de_serviço_Equipe1_idx` (`idEquipe` ASC) VISIBLE,
  CONSTRAINT `fk_Equipe_has_Ordem_de_serviço_Equipe1`
    FOREIGN KEY (`idEquipe`)
    REFERENCES `mydb`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Equipe_has_Ordem_de_serviço_Ordem_de_serviço1`
    FOREIGN KEY (`idOrdem_de_serviço` , `idTipo_serviço`)
    REFERENCES `mydb`.`Ordem_de_serviço` (`idOrdem_de_serviço` , `idTipo_serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`Peças_para_Orcamento` (
  `Peças_idPeças` INT(11) NOT NULL,
  `idOrdem_de_serviço` INT(11) NOT NULL,
  PRIMARY KEY (`Peças_idPeças`, `idOrdem_de_serviço`),
  INDEX `fk_Peças_has_Ordem_de_serviço_Ordem_de_serviço1_idx` (`idOrdem_de_serviço` ASC) VISIBLE,
  INDEX `fk_Peças_has_Ordem_de_serviço_Peças1_idx` (`Peças_idPeças` ASC) VISIBLE,
  CONSTRAINT `fk_Peças_has_Ordem_de_serviço_Peças1`
    FOREIGN KEY (`Peças_idPeças`)
    REFERENCES `mydb`.`Peças` (`idPeças`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peças_has_Ordem_de_serviço_Ordem_de_serviço1`
    FOREIGN KEY (`idOrdem_de_serviço`)
    REFERENCES `mydb`.`Ordem_de_serviço` (`idOrdem_de_serviço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

DROP TABLE IF EXISTS `mydb`.`rio` ;

DROP TABLE IF EXISTS `mydb`.`pais` ;

DROP TABLE IF EXISTS `mydb`.`cidade` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
