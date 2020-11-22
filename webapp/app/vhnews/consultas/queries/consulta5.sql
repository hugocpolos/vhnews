-- 5. Dado uma categoria, retornar todas as noticias/colunas
-- dessa categoria e seus documentos, assim como seu autor, data e seu numero de acessos.
-- exibir da mais recente para a mais antiga
SELECT materia.categoria,
   CASE
      WHEN
         noticias.data IS NOT NULL
      THEN
         noticias.data
      ELSE
         colunas.data
   END
   "data", materia.titulo, usuario.nome, materia.nro_acessos, documentos.link_bucket "documento"
FROM
   materia
   LEFT JOIN
      colunas
      ON colunas.idmateria = materia.id
   LEFT JOIN
      noticias
      ON noticias.idmateria = materia.id
   LEFT JOIN
      documentos
      ON documentos.idmateria = materia.id
   LEFT JOIN
      colunistas
      ON colunistas.idusuario = colunas.idcolunistas
   LEFT JOIN
      redatores
      ON redatores.idusuario = noticias.idredatores
   INNER JOIN
      usuario
      ON (usuario.id = colunistas.idusuario
      OR usuario.id = redatores.idusuario)
WHERE
   lower(materia.categoria) like LOWER(%s)
ORDER BY
   "data" DESC, materia.titulo
