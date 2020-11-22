-- 8. todos os numeros de cartoes de creditos, cvv, nome no cartao, validade e o nome e cpf dos solicitantes que tem
-- um pagamento pendente há mais de 7 dias.
SELECT
   cartaodecredito.nro_cartao,
   cartaodecredito.cvv,
   cartaodecredito.nome_no_cartao,
   cartaodecredito.validade,
   usuario.nome "nome solicitante",
   assinantes.cpf "cpf solicitante"
FROM
   usuario
   INNER JOIN
      assinantes
      ON assinantes.idusuario = usuario.id
   LEFT JOIN
      cartaodecredito
      ON cartaodecredito.id = assinantes.idcartaodecredito
WHERE
   EXISTS
   (
      SELECT
         *
      FROM
         assinaturas
      WHERE
         status_pagamento = 'PENDENTE'
         AND
         (
            now() - data_pedido
         )
         > '7 day'::INTERVAL
         AND idassinantes = assinantes.cpf
   )