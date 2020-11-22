"""
Rotas da api.

É utilizado o seguinte formato para a criação de novas rotas.

@{namespace}.route(<endpoint>)
class <endpoint>(Resource):
    def get(self, [args]):
        # método get desse endpoint
    def post(self, [args]):
        # método post desse endpoint

é também possivel definir os métodos, put, delete, etc.
para a documentação completa, acesse a documentação completa
da extensão flask-restful em:
https://flask-restful.readthedocs.io/en/latest/
"""
from flask_restplus import Resource, reqparse, Namespace
from . import repository

ns1 = Namespace('consulta1', description="Selecionar as notícias mais visualizadas de cada categoria, junto do nome de seu autor" )
ns2 = Namespace('consulta2', description="Selecionar todos os redatores e colunistas que nunca escreveram uma noticia ou coluna" )
ns3 = Namespace('consulta3', description="Listar os colunistas/redatores e a categoria que ele mais escreve." )
ns4 = Namespace('consulta4', description="Dado nome de um assinante ativo, recuperar toda a atividade do assinante: ou seja eventos de pagamentos e comentários, junto de suas datas, listados dos mais recentes para os mais antigos." )
ns5 = Namespace('consulta5', description="Dado uma categoria, retornar todas as noticias/colunas dessa categoria e seus documentos, assim como seu autor, data e seu numero de acessos. Exibir da mais recente para a mais antiga")
ns6 = Namespace('consulta6', description="Detalha Usuario: Dado o nome de um usuario, retornar se esse usuario é colunista/redator/assinante/usuário simples.")
ns7 = Namespace('consulta7', description="Pesquisa uma noticia/coluna pelo titulo: listando o autor, o numero de comentarios, o seu subtitulo, seu documento, sua data, sua categoria e seu numero de acessos")
ns8 = Namespace('consulta8', description="Todos os numeros de cartoes de creditos, cvv, nome no cartao, validade e o nome e cpf dos solicitantes que tem um pagamento pendente há mais de 7 dias.")
ns9 = Namespace('consulta9', description="Todos as categorias e seu numero de noticias/colunas e total de visualizações e comentários.")
ns10 = Namespace('consulta10', description="Todos os pagamentos pendentes, sunspenso ou realizado com sua data, data de vencimento, cartão de crédito que foi utilizado e nome do futuro ou atual assinante, assim como seu status de pagamento.")

@ns1.route('/')
class Consulta1(Resource):
    def get(self):
        return repository.consulta1() 

@ns2.route('/')
class Consulta1(Resource):
    def get(self):
        return repository.consulta2() 

@ns3.route('/')
class Consulta1(Resource):
    def get(self):
        return repository.consulta3() 

@ns4.route('/<assinante>')
class Consulta1(Resource):
    def get(self,assinante):
        return repository.consulta4(assinante) 

@ns5.route('/<categoria>')
class Consulta1(Resource):
    def get(self, categoria):
        return repository.consulta5(categoria) 

@ns6.route('/<usuario>')
class Consulta1(Resource):
    def get(self, usuario):
        return repository.consulta6(usuario) 

@ns7.route('/<titulo>')
class Consulta1(Resource):
    def get(self, titulo):
        return repository.consulta7(titulo)

@ns8.route('/')
class Consulta1(Resource):
    def get(self):
        return repository.consulta8() 

@ns9.route('/')
class Consulta1(Resource):
    def get(self):
        return repository.consulta9() 

@ns10.route('/')
class Consulta1(Resource):
    def get(self):
        return repository.consulta10()
