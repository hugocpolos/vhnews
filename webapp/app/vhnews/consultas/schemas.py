from integNossaAs import dependent_name_space 
from flask_restplus import fields

createDependentSchema = dependent_name_space.model('Create Dependent',
{
    'fullnameDependent': fields.String,
    'cpfDependent': fields.String(min=11, max=11),
    'cpfOwner': fields.String(min=11, max=11, required=False),
    'cnpjOwner': fields.String(min=14, max=14, required=False),
})

deleteDependentSchema = dependent_name_space.model('Delete Dependent',
{
    'cpfDependent': fields.String(min=11, max=11),
    'cpfOwner': fields.String(min=11, max=11, required=False),
    'cnpjOwner': fields.String(min=14, max=14, required=False),
})

createDependentResponseSchema = dependent_name_space.model('Create Dependent Response',
{
    'errors': fields.Raw(),
    'message': fields.String(),
    'args': fields.Nested(createDependentSchema)
})

deleteDependentResponseSchema = dependent_name_space.model('Delete Dependent Response',
{
    'errors': fields.Raw(),
    'message': fields.String(),
    'args': fields.Nested(deleteDependentSchema)
})

badRequestSchema = dependent_name_space.model('Bad Request Response',
{
    'errors': fields.Raw(),
    'message': fields.String()
})