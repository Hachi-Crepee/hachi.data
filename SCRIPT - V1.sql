DROP DATABASE hachi;
CREATE DATABASE IF NOT EXISTS hachi;
USE hachi;

CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(20) NOT NULL,
    telefone CHAR(11) NULL,
    pontos INT NOT NULL DEFAULT 0,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` TINYINT NOT NULL DEFAULT 0,
    CONSTRAINT statusUsuario
        CHECK (`status` = 1 OR `status`= 0)
);

CREATE TABLE beneficio (
    idBeneficio INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao VARCHAR(255) NULL,
    custo INT NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE compra (
    idCompra INT AUTO_INCREMENT PRIMARY KEY,
    codigo_nota_fiscal CHAR(44) NOT NULL UNIQUE,
    valor DECIMAL(10,2) NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    fk_usuario INT NOT NULL,
    CONSTRAINT fk_compra_usuario
        FOREIGN KEY (fk_usuario) REFERENCES usuario(idUsuario)
);

CREATE TABLE resgate (
    idResgate INT NOT NULL,
    custo INT NOT NULL,
    data_resgate DATETIME NOT NULL,
    fk_usuario INT NOT NULL,
    fk_beneficio INT NOT NULL,
    CONSTRAINT pk_resgate
        PRIMARY KEY (idResgate, fk_usuario, fk_beneficio),
    CONSTRAINT fk_resgate_usuario
        FOREIGN KEY (fk_usuario)
        REFERENCES usuario(idUsuario),
    CONSTRAINT fk_resgate_beneficio
        FOREIGN KEY (fk_beneficio)
        REFERENCES beneficio(idBeneficio)
);

CREATE TABLE feedback (
	idFeedback INT AUTO_INCREMENT PRIMARY KEY,
    nota INT NOT NULL,
    comentario VARCHAR(255),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fk_usuario INT NOT NULL,
    CONSTRAINT fk_feedback_usuario
		FOREIGN KEY (fk_usuario)
        REFERENCES usuario(idUsuario)
);

CREATE TABLE solicitacao_musica (
	idSolicitacao INT AUTO_INCREMENT PRIMARY KEY,
    musica VARCHAR(255) NOT NULL,
    artista VARCHAR(255) NOT NULL,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fk_usuario INT NOT NULL,
    CONSTRAINT fk_musica_usuario
		FOREIGN KEY (fk_usuario)
        REFERENCES usuario(idUsuario)
);
