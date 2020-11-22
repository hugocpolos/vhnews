-- 7. Pesquisa uma noticia/coluna pelo titulo: listando o autor,
-- o numero de comentarios, o seu subtitulo, seu documento,
-- sua data, sua categoria e seu numero de acessos
SELECT
   materia.titulo,
   usuario.nome "autor",
   COUNT(comentarios.id) "nro comentarios",
   materia.subtitulo,
   documentos.link_bucket "documento",
   CASE
      WHEN
         noticias.data IS NOT NULL 
      THEN
         noticias.data 
      ELSE
         colunas.data 
   END
, materia.categoria, materia.nro_acessos 
FROM
   materia 
   LEFT JOIN
      colunas 
      ON colunas.idmateria = materia.id 
   LEFT JOIN
      noticias 
      ON noticias.idmateria = materia.id 
   LEFT JOIN
      colunistas 
      ON colunistas.idusuario = colunas.idcolunistas 
   LEFT JOIN
      redatores 
      ON redatores.idusuario = noticias.idredatores 
   INNER JOIN
      usuario 
      ON (redatores.idusuario = usuario.id 
      OR colunistas.idusuario = usuario.id) 
   LEFT JOIN
      documentos 
      ON (documentos.idmateria = materia.id) 
   LEFT JOIN
      comentarios 
      ON (comentarios.idnoticias = noticias.idmateria) 
WHERE
   LOWER(materia.titulo) LIKE LOWER(%s) 
GROUP BY
   materia.titulo, usuario.nome, materia.subtitulo, documentos.link_bucket, noticias.data, colunas.data, materia.categoria, materia.nro_acessos

