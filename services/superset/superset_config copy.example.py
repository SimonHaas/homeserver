ENABLE_PROXY_FIX = True

# openssl rand -base64 42
SECRET_KEY = 'zbeLjToOiMkz09qNonioiLs+MspZpPoJlt+Xp5UV5yWafhNX9jzcnDVs'

SQLALCHEMY_DATABASE_URI = 'mysql://password:username@db/superset_metadata'

# Die Datenbank für die Beispieldaten muss 'main' heißen. Die wird aber nur gebraucht wenn auch Beispieldaten gewünscht sind.
SQLALCHEMY_EXAMPLES_URI = 'mysql://password:username@db/main'

LANGUAGES = {
    'en': {'flag': 'us', 'name': 'English'},
    'de': {'flag': 'de', 'name': 'Deutsch'},
}

FEATURE_FLAGS = {
    'EMBEDDABLE_CHARTS': True,
    'EMBEDDED_SUPERSET': True,
    'THUMBNAILS': True,
    'ENABLE_TEMPLATE_PROCESSING': True,
}
