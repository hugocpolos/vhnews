-- 6. Detalha Usuario: Dado o nome de um usuario, retornar se esse usuario
-- é colunista/redator/assinante/usuário simples.
SELECT
   usuario.nome,
   CASE
      WHEN
         usuario.id IN 
         (
            SELECT
               idusuario 
            FROM
               colunistas
         )
      THEN
         'COLUNISTA' 
      WHEN
         usuario.id IN 
         (
            SELECT
               idusuario 
            FROM
               redatores
         )
      THEN
         'REDATOR' 
      WHEN
         usuario.id IN 
         (
            SELECT
               idusuario 
            FROM
               assinantes
         )
      THEN
         'ASSINANTE' 
      ELSE
         'USUARIO SIMPLES' 
   END
FROM
   usuario 
WHERE
   LOWER(usuario.nome) LIKE LOWER(%s)
