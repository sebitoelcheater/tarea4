SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `tarea4` ;
USE `tarea4` ;

-- -----------------------------------------------------
-- Table `tarea4`.`tipo_usuario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tarea4`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL AUTO_INCREMENT ,
  `nombre_tipo` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`idtipo_usuario`) ,
  UNIQUE INDEX `idtipo_usuario_UNIQUE` (`idtipo_usuario` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea4`.`usuarios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tarea4`.`usuarios` (
  `idusuarios` INT NOT NULL AUTO_INCREMENT ,
  `nombre_usuario` VARCHAR(45) NULL DEFAULT NULL ,
  `password` VARCHAR(45) NULL DEFAULT NULL ,
  `nombre` VARCHAR(45) NULL DEFAULT NULL ,
  `apellido` VARCHAR(45) NULL DEFAULT NULL ,
  `rut` VARCHAR(45) NULL DEFAULT NULL ,
  `direccion` VARCHAR(45) NULL DEFAULT NULL ,
  `telefono` VARCHAR(45) NULL DEFAULT NULL ,
  `email` VARCHAR(45) NULL DEFAULT NULL ,
  `fecha_registro` TIMESTAMP NULL DEFAULT NULL ,
  `ultima_sesion` TIMESTAMP NULL DEFAULT NULL ,
  `tipo_usuario_idtipo_usuario` INT NOT NULL ,
  PRIMARY KEY (`idusuarios`) ,
  INDEX `fk_usuarios_tipo_usuario` (`tipo_usuario_idtipo_usuario` ASC) ,
  UNIQUE INDEX `idusuarios_UNIQUE` (`idusuarios` ASC) ,
  CONSTRAINT `fk_usuarios_tipo_usuario`
    FOREIGN KEY (`tipo_usuario_idtipo_usuario` )
    REFERENCES `tarea4`.`tipo_usuario` (`idtipo_usuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea4`.`producto_servicio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tarea4`.`producto_servicio` (
  `idproducto_servicio` INT NOT NULL AUTO_INCREMENT ,
  `nombre` VARCHAR(45) NULL DEFAULT NULL ,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL ,
  `precio` INT NULL DEFAULT NULL ,
  `stock` VARCHAR(45) NULL DEFAULT NULL ,
  `fecha_publicacion` TIMESTAMP NULL DEFAULT NULL ,
  `usuarios_idusuarios` INT NOT NULL ,
  PRIMARY KEY (`idproducto_servicio`) ,
  INDEX `fk_producto_servicio_usuarios1` (`usuarios_idusuarios` ASC) ,
  UNIQUE INDEX `idproducto_servicio_UNIQUE` (`idproducto_servicio` ASC) ,
  CONSTRAINT `fk_producto_servicio_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` )
    REFERENCES `tarea4`.`usuarios` (`idusuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea4`.`metodo_compra`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tarea4`.`metodo_compra` (
  `idmetodo_compra` INT NOT NULL AUTO_INCREMENT ,
  `tipo_metodo` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`idmetodo_compra`) ,
  UNIQUE INDEX `idmetodo_compra_UNIQUE` (`idmetodo_compra` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea4`.`compra`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tarea4`.`compra` (
  `idcompra` INT NOT NULL AUTO_INCREMENT ,
  `fecha_compra` TIMESTAMP NULL DEFAULT NULL ,
  `usuarios_idusuarios` INT NOT NULL ,
  `metodo_compra_idmetodo_compra` INT NOT NULL ,
  PRIMARY KEY (`idcompra`) ,
  INDEX `fk_compra_usuarios1` (`usuarios_idusuarios` ASC) ,
  INDEX `fk_compra_metodo_compra1` (`metodo_compra_idmetodo_compra` ASC) ,
  UNIQUE INDEX `idcompra_UNIQUE` (`idcompra` ASC) ,
  CONSTRAINT `fk_compra_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios` )
    REFERENCES `tarea4`.`usuarios` (`idusuarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_metodo_compra1`
    FOREIGN KEY (`metodo_compra_idmetodo_compra` )
    REFERENCES `tarea4`.`metodo_compra` (`idmetodo_compra` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tarea4`.`compra_producto_servicio`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `tarea4`.`compra_producto_servicio` (
  `compra_idcompra` INT NOT NULL ,
  `producto_servicio_idproducto_servicio` INT NOT NULL ,
  `cantidad` INT NULL DEFAULT NULL ,
  PRIMARY KEY (`compra_idcompra`, `producto_servicio_idproducto_servicio`) ,
  INDEX `fk_compra_has_producto_servicio_producto_servicio1` (`producto_servicio_idproducto_servicio` ASC) ,
  INDEX `fk_compra_has_producto_servicio_compra1` (`compra_idcompra` ASC) ,
  CONSTRAINT `fk_compra_has_producto_servicio_compra1`
    FOREIGN KEY (`compra_idcompra` )
    REFERENCES `tarea4`.`compra` (`idcompra` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_has_producto_servicio_producto_servicio1`
    FOREIGN KEY (`producto_servicio_idproducto_servicio` )
    REFERENCES `tarea4`.`producto_servicio` (`idproducto_servicio` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
