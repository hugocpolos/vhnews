from flask import Flask, redirect
from os import environ
from flask_restplus import Api, fields, Resource
import vhnews.consultas.controller as controller

app = Flask(__name__)
app.config['SECRET_KEY'] = b'\xdd\xa4\x03\x84\xda\xa9\x98\t\x7f\xa4\xb3\xae\xa8\xa0\x1c\xf6\xc7C\xc8(\x96W\xecb' 
app.config['ERROR_404_HELP'] = False

api = Api(app, version=1.0, title="VHNews", description='API para consulta na base do jornal VHNews')

api.add_namespace(controller.ns1)
api.add_namespace(controller.ns2)
api.add_namespace(controller.ns3)
api.add_namespace(controller.ns4)
api.add_namespace(controller.ns5)
api.add_namespace(controller.ns6)
api.add_namespace(controller.ns7)
api.add_namespace(controller.ns8)
api.add_namespace(controller.ns9)
api.add_namespace(controller.ns10)
