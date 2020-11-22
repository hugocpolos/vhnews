--POSTGRESQL
CREATE database vhnews;
\connect "vhnews";

DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS redatores CASCADE;
DROP TABLE IF EXISTS colunistas CASCADE;
DROP TABLE IF EXISTS assinaturas CASCADE;
DROP TABLE IF EXISTS cartaodecredito CASCADE;
DROP TABLE IF EXISTS materia CASCADE;
DROP TABLE IF EXISTS noticias CASCADE;
DROP TABLE IF EXISTS colunas CASCADE;
DROP TABLE IF EXISTS comentarios CASCADE;
DROP TABLE IF EXISTS documentos CASCADE;
DROP TABLE IF EXISTS assinantes CASCADE;

CREATE TABLE usuario ( id serial PRIMARY key, nome VARCHAR(80) NOT NULL, email VARCHAR(80) UNIQUE NOT NULL );
CREATE TABLE redatores ( idusuario INTEGER PRIMARY key );
CREATE TABLE colunistas ( idusuario INTEGER PRIMARY key );
CREATE TABLE assinaturas ( id serial PRIMARY key, status_assinatura VARCHAR(10) NOT NULL, status_pagamento VARCHAR(10) NOT NULL, valor NUMERIC(5, 2) NOT NULL, data_vencimento TIMESTAMP NOT NULL, data_pedido TIMESTAMP NOT NULL, data_aprovacao TIMESTAMP, idcartaodecredito INTEGER NOT NULL, idassinantes VARCHAR(11) NOT NULL );
CREATE TABLE cartaodecredito ( id serial PRIMARY key, nro_cartao VARCHAR(12) NOT NULL, cvv VARCHAR(3) NOT NULL, validade VARCHAR(4) NOT NULL, nome_no_cartao VARCHAR(40) NOT NULL );
CREATE TABLE materia ( id serial PRIMARY key, titulo VARCHAR(40) NOT NULL, subtitulo VARCHAR(80) NOT NULL, categoria VARCHAR(40) NOT NULL, nro_acessos INTEGER NOT NULL );
CREATE TABLE noticias ( idmateria INTEGER PRIMARY key, data TIMESTAMP NOT NULL, idredatores INTEGER NOT NULL );
CREATE TABLE colunas ( idmateria INTEGER PRIMARY key, data TIMESTAMP NOT NULL, idcolunistas INTEGER NOT NULL );
CREATE TABLE comentarios ( id serial PRIMARY key, data TIMESTAMP NOT NULL, mensagem VARCHAR(200) NOT NULL, idnoticias INTEGER NOT NULL, idusuario INTEGER NOT NULL );
CREATE TABLE documentos ( id serial PRIMARY key, link_bucket VARCHAR(200) NOT NULL, idmateria INTEGER NOT NULL );
CREATE TABLE assinantes ( cpf VARCHAR(11) PRIMARY key, idusuario INTEGER NOT NULL, idcartaodecredito INTEGER NOT NULL );

ALTER TABLE redatores ADD FOREIGN key(idusuario) REFERENCES usuario (id) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE colunistas ADD FOREIGN key(idusuario) REFERENCES usuario (id) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE assinaturas ADD FOREIGN key(idcartaodecredito) REFERENCES cartaodecredito (id) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE assinaturas ADD FOREIGN key(idassinantes) REFERENCES assinantes (cpf) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE noticias ADD FOREIGN key(idmateria) REFERENCES materia (id) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE noticias ADD FOREIGN key(idredatores) REFERENCES redatores (idusuario) 
ON 
DELETE
SET
   NULL 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE colunas ADD FOREIGN key(idmateria) REFERENCES materia (id) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE colunas ADD FOREIGN key(idcolunistas) REFERENCES colunistas (idusuario) 
ON 
DELETE
SET
   NULL 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE comentarios ADD FOREIGN key(idnoticias) REFERENCES noticias (idmateria) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE comentarios ADD FOREIGN key(idusuario) REFERENCES usuario (id) 
ON 
DELETE
SET
   NULL 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE documentos ADD FOREIGN key(idmateria) REFERENCES materia (id) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE assinantes ADD FOREIGN key(idusuario) REFERENCES usuario (id) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE assinantes ADD FOREIGN key(idcartaodecredito) REFERENCES cartaodecredito (id) 
ON 
DELETE
   CASCADE 
   ON 
   UPDATE
      CASCADE;

ALTER TABLE assinaturas ADD CONSTRAINT constrain_assinatura_status_assinatura CHECK (status_assinatura IN 
(
   'ATIVA', 'PENDENTE', 'CANCELADA'
)
);
ALTER TABLE assinaturas ADD CONSTRAINT constrain_assinatura_status_pagamento CHECK (status_pagamento IN 
(
   'APROVADO', 'PENDENTE', 'REJEITADO'
)
);
ALTER TABLE assinaturas ADD CONSTRAINT constrain_assinatura_data_aprovacao CHECK (data_aprovacao >= data_pedido);
ALTER TABLE assinaturas ADD CONSTRAINT constrain_assinatura_data_vencimento CHECK (data_vencimento >= data_aprovacao);
ALTER TABLE usuario ADD CONSTRAINT usuario_proper_email CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$');

-- CREATE VIEW assinantes ativos
CREATE view assinantes_ativos AS 
SELECT
   usuario.id,
   usuario.nome,
   assinaturas.data_vencimento,
   assinantes.cpf,
   cartaodecredito.nro_cartao,
   assinaturas.valor 
FROM
   assinaturas 
   INNER JOIN
      assinantes 
      ON assinantes.cpf = assinaturas.idassinantes 
   INNER JOIN
      usuario 
      ON usuario.id = assinantes.idusuario 
   INNER JOIN
      cartaodecredito 
      ON cartaodecredito.id = assinantes.idcartaodecredito 
WHERE
   assinaturas.status_assinatura = 'ATIVA' 
ORDER BY
   assinaturas.valor DESC;


-- INSERT DATA
INSERT INTO
   "usuario" ("id", "nome", "email") 
VALUES
   (
      1,
      'Hugo',
      'hugo@ufrgs.com'
   )
,
   (
      2,
      'vilmar',
      'vilmar@ufrgs.br'
   )
,
   (
      3,
      'Renata',
      'renata@ufrgs.br'
   )
,
   (
      4,
      'João',
      'joao@email.com'
   )
,
   (
      5,
      'Maria',
      'maria@email.com'
   )
,
   (
      7,
      'Alexa Malena Salazar',
      'srtaar@gmail.com'
   )
,
   (
      8,
      'Teobaldo Beltrão Lira',
      'srteobira@gmail.com'
   )
,
   (
      9,
      'Miguel Lutero Neto',
      'srmito@gmail.com'
   )
,
   (
      10,
      'Paulina Thalissa Roque Jr.',
      'drpauljr@gmail.com'
   )
,
   (
      11,
      'Rafaela Lovato',
      'rafaelato@gmail.com'
   )
,
   (
      6,
      'Ornela Domingues Filho',
      'srtaorlho@gmail.com'
   )
;
INSERT INTO
   "colunistas" ("idusuario") 
VALUES
   (
      2
   )
,
   (
      5
   )
,
   (
      8
   )
,
   (
      11
   )
;
INSERT INTO
   "redatores" ("idusuario") 
VALUES
   (
      1
   )
,
   (
      4
   )
,
   (
      7
   )
,
   (
      10
   )
;
INSERT INTO
   "cartaodecredito" ("id", "nro_cartao", "cvv", "validade", "nome_no_cartao") 
VALUES
   (
      1,
      '521974881325',
      '752',
      '0521',
      'RENATA'
   )
,
   (
      2,
      '551454792227',
      '710',
      '1021',
      'ORNELADOMINGUESFILHO'
   )
,
   (
      3,
      '520158016410',
      '450',
      '0722',
      'MIGUELLUTERONETO'
   )
;
INSERT INTO
   "materia" ("id", "titulo", "subtitulo", "categoria", "nro_acessos") 
VALUES
   (
      1,
      'Confusão no Rio',
      'Coach roqueiro pilota ambulância na orla carioca',
      'Variedades',
      2500
   )
,
   (
      2,
      'Ato de preservação na capital paulista',
      'Presidiário vestido de palhaço resgata filhote de tamanduá na avenida Paulista',
      'Natureza',
      10600
   )
,
   (
      3,
      'Congressistas em choque!',
      'Presidiário bêbado esquece filhos no Congresso Nacional',
      'Política',
      6100
   )
,
   (
      4,
      'Resumo do Grenal',
      'Todo mundo jogou mal e quem saiu vitorioso foi o empate futebol clube',
      'Esporte',
      5000
   )
,
   (
      5,
      'O resultado das urnas',
      'Mais uma vez a democracia falou mais alto',
      'Política',
      4300
   )
,
   (
      6,
      'Carnaval 2022?',
      'O que sabemos sobre os preparativos da festa mais aguardada do momento',
      'Variedades',
      20000
   )
,
   (
      7,
      'Coluna sobre esporte!',
      'Tudo o que aconteceu no fim de semana',
      'Esporte',
      500
   )
,
   (
      8,
      'Também falarei de politica',
      'mas nao tanto quanto falo de esporte...',
      'Política',
      22
   )
;
INSERT INTO
   "assinantes" ("cpf", "idusuario", "idcartaodecredito") 
VALUES
   (
      '12440284017',
      3,
      1
   )
,
   (
      '60142040088',
      6,
      2
   )
,
   (
      '52918245062',
      9,
      3
   )
;
INSERT INTO
   "assinaturas" ("id", "status_assinatura", "status_pagamento", "valor", "data_vencimento", "data_pedido", "data_aprovacao", "idcartaodecredito", "idassinantes") 
VALUES
   (
      1,
      'ATIVA',
      'APROVADO',
      10.90,
      '2020-12-31 00:00:00',
      '2020-11-22 00:00:00',
      '2020-11-22 00:00:00',
      1,
      '12440284017'
   )
,
   (
      2,
      'PENDENTE',
      'REJEITADO',
      10.90,
      '2021-12-31 00:00:00',
      '2020-11-22 00:00:00',
      NULL,
      2,
      '60142040088'
   )
,
   (
      3,
      'CANCELADA',
      'PENDENTE',
      19.99,
      '2021-12-31 00:00:00',
      '2020-02-01 00:00:00',
      '2020-02-04 00:00:00',
      3,
      '52918245062'
   )
;
INSERT INTO
   "colunas" ("idmateria", "data", "idcolunistas") 
VALUES
   (
      4,
      '2020-11-20 00:00:00',
      2
   )
,
   (
      5,
      '2019-09-15 00:00:00',
      5
   )
,
   (
      6,
      '2020-05-20 00:00:00',
      11
   )
,
   (
      7,
      '2020-08-21 00:00:00',
      2
   )
,
   (
      8,
      '2020-09-14 00:00:00',
      2
   )
;
INSERT INTO
   "documentos" ("id", "link_bucket", "idmateria") 
VALUES
   (
      1,
      'http://fdnced.mpjfjvd.no',
      1
   )
,
   (
      2,
      'http://obmlkkpin.ltxreyycpofq',
      2
   )
,
   (
      3,
      'http://bkryar.ymplqdjpxjo.org',
      3
   )
,
   (
      4,
      ' http://ytwikw.pfdtmwdzwvql',
      4
   )
,
   (
      5,
      'http://iudcejqxeuvu.adbpsiuz.info',
      5
   )
,
   (
      6,
      'http://hbldimlsghvt.dlghwhcbf.gov',
      6
   )
;
INSERT INTO
   "noticias" ("idmateria", "data", "idredatores") 
VALUES
   (
      1,
      '2018-06-20 00:00:00',
      1
   )
,
   (
      2,
      '2019-04-11 00:00:00',
      4
   )
,
   (
      3,
      '2020-10-05 00:00:00',
      7
   )
;
INSERT INTO
   "comentarios" ("id", "data", "mensagem", "idnoticias", "idusuario") 
VALUES
   (
      1,
      '2020-11-05 00:00:00',
      'Muito Bom! KKKKK',
      1,
      5
   )
,
   (
      2,
      '2020-11-06 00:00:00',
      'Putz, não acredito que estão noticiando isso! Que jornaleco',
      2,
      10
   )
,
   (
      3,
      '2020-11-07 00:00:00',
      'Ba, a que ponto chegamos hein...',
      3,
      8
   )
,
   (
      4,
      '2020-11-21 00:00:00',
      'Que legal!',
      3,
      3
   )
,
   (
      5,
      '2020-11-21 17:36:32.133055',
      'Caramba, que loucura!',
      1,
      5
   )
;

