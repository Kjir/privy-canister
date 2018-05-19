from os import environ

worker_class = "quart.worker.GunicornWorker"
bind = "0.0.0.0:5000"

reload = environ.get('QUART_ENV') == 'development'
