-- 9. todos as categorias e seu numero de noticias/colunas e total de visualizações e comentários.
SELECT
   materia.categoria,
   COUNT(colunas.idmateria) "numero de colunas",
   COUNT(noticias.idmateria) "numero de noticias",
   COUNT(noticias.idmateria) + COUNT(comentarios.id) "total de publicacoes",
   COUNT(comentarios.id) "nro de comentarios",
   SUM(materia.nro_acessos) "total de acessos" 
FROM
   materia 
   LEFT JOIN
      colunas 
      ON colunas.idmateria = materia.id 
   LEFT JOIN
      noticias 
      ON noticias.idmateria = materia.id 
   LEFT JOIN
      comentarios 
      ON comentarios.idnoticias = noticias.idmateria 
GROUP BY
   materia.categoria 
ORDER BY
   "total de acessos" DESC
