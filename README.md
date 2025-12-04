# Docker-compose Config for Local

Place the docker-compose.yaml file in the parent directory.

```yaml
  web:
    build:
      context: ./mpfana-web
      dockerfile: Dockerfile
      target: development
    container_name: mpfana_web
    ports:
      - "3000:3000" # UI port
    depends_on:
      - api
    volumes:
      - ./mpfana-web:/app
      - /app/node_modules
    networks:
      - mpfana_net
```
