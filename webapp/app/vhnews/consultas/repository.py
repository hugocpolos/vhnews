from vhnews.repository import PostgresConnection
from . import models

db = PostgresConnection(user = 'postgres',
                 passwd='mypass',
                 db_host='db',
                 db_name='vhnews')

def __clean_execute(query, arg=None):
    response_code = 200
    try:
        db.connect()
    except Exception as e:
        return str(e), 500
    try:
        result = db.select(query, arg)
    except Exception as e:
        result = str(e)
        response_code = 400
    finally:
        db.close()
    return result, response_code
 
def consulta1():
    return __clean_execute(models.query_consulta1)

def consulta2():
    return __clean_execute(models.query_consulta2)

def consulta3():
    return __clean_execute(models.query_consulta3)

def consulta4(arg=None):
    return __clean_execute(models.query_consulta4, (arg,arg))

def consulta5(arg=None):
    return __clean_execute(models.query_consulta5, ('%'+arg+'%',))

def consulta6(arg=None):
    return __clean_execute(models.query_consulta6, ('%'+arg+'%',))

def consulta7(arg=None):
    return __clean_execute(models.query_consulta7, ('%'+arg+'%',))

def consulta8():
    return __clean_execute(models.query_consulta8)

def consulta9():
    return __clean_execute(models.query_consulta9)

def consulta10():
    return __clean_execute(models.query_consulta10)