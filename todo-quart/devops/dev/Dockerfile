FROM python:3.6

WORKDIR /app

RUN pip install pipenv

COPY Pipfile Pipfile.lock ./
RUN pipenv install

ENV QUART_APP=todo:app QUART_ENV=development
CMD ["pipenv", "run", "quart", "run"]