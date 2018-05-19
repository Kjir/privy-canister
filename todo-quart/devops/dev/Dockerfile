FROM python:3.6

WORKDIR /app

RUN pip install pipenv

COPY Pipfile Pipfile.lock ./
RUN pipenv install --system

COPY . .

ENV QUART_APP=todo:app QUART_ENV=development
CMD gunicorn -c config/gunicorn.py $QUART_APP
