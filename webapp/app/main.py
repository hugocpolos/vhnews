from vhnews import app
import argparse
from sys import argv


helpmessage = """
Por padrao, o aplicativo iniciara em modo de Debug
 no endereco http://localhost:10000.
Para alterar o modo debug ou a porta,
 sao utilizados os seguintes parametros:
[--port | -p] <inteiro> para definir a porta utilizada.
[--nodebug | -nd] para desativar o modo debug
Exemplo, para rodar a aplicacao na porta 12000 sem debug:
python ' + argv[0] + ' -p 12000 -nd"""

if __name__ == '__main__':

    if len(argv) == 1:
        print(helpmessage)

    else:
        parser = argparse.ArgumentParser()
        parser.add_argument(
            "--port", "-p",
            help="Seleciona a porta tcp para rodar a aplicação")
        parser.add_argument(
            "--nodebug", "-nd",
            help="desativa o modo debug", action="store_true")

        args = parser.parse_args()
        port = int(args.port) if args.port is not None else 10000
        debug = not args.nodebug

        app.run(debug=debug, host='0.0.0.0', port=port)
