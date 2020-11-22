-- 10. Todos os pagamentos pendentes, sunspenso ou realizado com sua data,
-- data de vencimento, cartão de crédito que foi utilizado
-- e nome do futuro ou atual assinante, assim como seu status de pagamento.

select
assinaturas.status_pagamento, cartaodecredito.nro_cartao, cartaodecredito.cvv, cartaodecredito.nome_no_cartao
from assinaturas
inner join assinantes on assinantes.cpf = assinaturas.idassinantes
inner join cartaodecredito on cartaodecredito.id = assinantes.idcartaodecredito
inner join usuario on usuario.id = assinantes.idusuario
