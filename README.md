# aisync
AI Sync Demo App

## Starting

```
cd back
docker compose up

curl -u 'admin:zxc123' --request PUT http://localhost:4985/aisync/ --header 'Content-Type: application/json' --data-raw '{ "bucket": "aisync", "num_index_replicas": 0 }'

curl -u 'admin:zxc123' --request POST http://localhost:4985/aisync/_user/ -H 'Content-Type: application/json' -d '{ "name": "admin", "password": "zxc123" }'
```
