# Hobbes server
This is a server app for a private project of hobby management system.

## docker-compose
In order to start up the whole environment locally run:
```shell
docker-compose up -d
```

which starts the whole backend environment up.

## Microservices
This backend was built in microservices architecture and contains:

| service        | language | framework |
|----------------|----------|-----------|
| keycloak       |          |           |
| surfing server | java     | javalin   |ś