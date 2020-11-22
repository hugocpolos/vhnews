"""Programa que define a classe PostgresConnection, utilizada para acessar e realizar
operações em um banco postgres utilizando a biblioteca psycopg2
"""
import psycopg2
import datetime

class PostgresConnection(object):
    """Conexão com um banco postgres
    """

    def __init__(self, user,
                 passwd,
                 db_host,
                 db_name):
        """Construtor da classe

        Args:
            arg_user (str): usuário do banco
            arg_pwd (str): senha do banco
            arg_host (str): host do banco
            arg_db (str): nome do database
        """
        super(PostgresConnection, self).__init__()
        self.user = user
        self.passwd = passwd 
        self.db_host = db_host 
        self.db_name = db_name
        self.__connection = None
        self.__cursor = None

    def connect(self):
        self.__connection = psycopg2.connect(
            user=self.user, password=self.passwd,
            host=self.db_host, database=self.db_name)
        self.__cursor = self.__connection.cursor()

    def select(self, select_query, args=None):
        """
        Executa a query de select passada em <select_query> e retorna uma lista de objetos contendo seu resultado.
        """
        if self.__connection is not None and self.__cursor is not None:
            self.__cursor.execute(select_query,args)
            values = self.__cursor.fetchall()
            fields = [row[0] for row in self.__cursor.description]
            return_dict = []
            for x in values:
                dict_entry = {}
                for j in range(len(fields)):
                    if isinstance(x[j], datetime.datetime):
                        dict_entry[fields[j]] = str(x[j])
                    else:
                        dict_entry[fields[j]] = x[j]
                return_dict.append(dict_entry)
            return return_dict

        else:
            raise Exception("Unable to query before oppening a connection with the connect() method")

    def close(self):
        """Encerra a conexão com o banco
        """
        if self.__connection is not None:
            self.__connection.close()
            self.__cursor = None

