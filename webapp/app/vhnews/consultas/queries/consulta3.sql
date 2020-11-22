-- 3. Listar os colunista/redatores e a categoria que ele mais escreve.
(
SELECT
   all_colunas.nome,
   'COLUNISTA' funcao,
   all_colunas.categoria "principal categoria"
FROM
   (
      SELECT
         row_number() OVER (PARTITION BY usuario.nome
      ORDER BY
         count(materia.categoria) DESC) AS r,
         usuario.nome,
         materia.categoria,
         count(materia.categoria) N
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
      GROUP BY
         materia.categoria,
         usuario.nome
   )
   as all_colunas
GROUP BY
   all_colunas.nome,
   all_colunas.r,
   all_colunas.categoria,
   all_colunas.n
having
   all_colunas.r <= 1
)
union
(
SELECT
   all_noticias.nome, 'REDATOR' funcao, all_noticias.categoria "principal categoria"
FROM
   (
      SELECT
         row_number() OVER (PARTITION BY usuario.nome
      ORDER BY
         count(materia.categoria) DESC) AS r,
         usuario.nome,
         materia.categoria,
         count(materia.categoria) N
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
      GROUP BY
         materia.categoria,
         usuario.nome
   )
   as all_noticias
GROUP BY
   all_noticias.nome, all_noticias.r, all_noticias.categoria, all_noticias.n
having
   all_noticias.r <= 1
)

ORDER BY
   funcao,
   nome
