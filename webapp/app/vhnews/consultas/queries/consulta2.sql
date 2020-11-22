-- 2. Selecionar todos os redatores e colunistas que nunca escreveram uma noticia ou coluna
SELECT
   usuario.nome,
   'COLUNISTA' funcao 
FROM
   colunistas 
   INNER JOIN
      usuario 
      on usuario.id = colunistas.idusuario 
WHERE
   usuario.nome not in
   (
      SELECT
         usuario.nome 
      FROM
         colunistas 
         INNER JOIN
            usuario 
            on usuario.id = colunistas.idusuario 
         INNER JOIN
            colunas 
            on colunas.idcolunistas = colunistas.idusuario 
         INNER JOIN
            materia 
            on materia.id = colunas.idmateria
   )
union
( 
SELECT
   usuario.nome, 'REDATOR' funcao 
FROM
   redatores 
   INNER JOIN
      usuario 
      on usuario.id = redatores.idusuario 
WHERE
   usuario.nome not in
   (
      SELECT
         usuario.nome 
      FROM
         redatores 
         INNER JOIN
            usuario 
            on usuario.id = redatores.idusuario 
         INNER JOIN
            noticias 
            on noticias.idredatores = redatores.idusuario 
         INNER JOIN
            materia 
            on materia.id = noticias.idmateria 
   )
)
