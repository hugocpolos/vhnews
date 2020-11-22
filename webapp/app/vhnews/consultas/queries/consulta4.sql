-- 4. Dado nome de um assinante ativo,
-- recuperar toda a atividade do assinante:
-- ou seja eventos de pagamentos e comentários,
-- junto de suas datas, listados dos mais recentes para os mais antigos.
(( 
	select
	   'pagamento' evento, assinaturas.data_aprovacao "Data evento" 
	FROM
	   assinantes_ativos 
	   INNER JOIN
	      assinaturas 
	      on assinaturas.idassinantes = assinantes_ativos.cpf 
	where
	   lower(assinantes_ativos.nome) = lower(%s)
	) 
union
( 
	select
	   'comentário' evento, comentarios.data "Data evento" 
	FROM
	   assinantes_ativos 
	   INNER JOIN
	      comentarios 
	      on comentarios.idusuario = assinantes_ativos.id 
	where
	   lower(assinantes_ativos.nome) = lower(%s)
)) 
ORDER BY
   "Data evento" DESC
