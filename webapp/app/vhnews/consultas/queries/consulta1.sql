-- 1. Selecionar as notícias mais visualizadas de cada categoria, junto do nome de seu autor

SELECT
   materia.categoria,
   materia.titulo,
   usuario.nome,
   max(materia.nro_acessos)
FROM
   materia
   INNER JOIN
      noticias
      ON noticias.idmateria = materia.id
   INNER JOIN
      redatores
      ON noticias.idredatores = redatores.idusuario
   INNER JOIN
      usuario
      ON redatores.idusuario = usuario.id
GROUP BY
   materia.categoria,
   materia.titulo,
   usuario.nome
