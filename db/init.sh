#!/bin/bash

/entrypoint.sh couchbase-server & 

echo $COUCHBASE_ADMINISTRATOR_USERNAME ":"  $COUCHBASE_ADMINISTRATOR_PASSWORD  

sleep 10s

/opt/couchbase/bin/couchbase-cli cluster-init -c 127.0.0.1 \
--cluster-username $COUCHBASE_ADMINISTRATOR_USERNAME \
--cluster-password $COUCHBASE_ADMINISTRATOR_PASSWORD \
--services data,index,query \
--cluster-ramsize $COUCHBASE_RAM_SIZE \
--cluster-index-ramsize $COUCHBASE_INDEX_RAM_SIZE \
--index-storage-setting default

sleep 2s

# used to auto create the bucket based on environment variables
# https://docs.couchbase.com/server/current/cli/cbcli/couchbase-cli-bucket-create.html

/opt/couchbase/bin/couchbase-cli bucket-create -c localhost:8091 \
--username $COUCHBASE_ADMINISTRATOR_USERNAME \
--password $COUCHBASE_ADMINISTRATOR_PASSWORD \
--bucket $COUCHBASE_BUCKET \
--bucket-ramsize $COUCHBASE_BUCKET_RAMSIZE \
--bucket-type couchbase 

sleep 2s

# used to auto create the sync gateway user based on environment variables  
# https://docs.couchbase.com/server/current/cli/cbcli/couchbase-cli-user-manage.html#examples

/opt/couchbase/bin/couchbase-cli user-manage \
--cluster http://127.0.0.1 \
--username $COUCHBASE_ADMINISTRATOR_USERNAME \
--password $COUCHBASE_ADMINISTRATOR_PASSWORD \
--set \
--rbac-username $COUCHBASE_RBAC_USERNAME \
--rbac-password $COUCHBASE_RBAC_PASSWORD \
--roles mobile_sync_gateway[*] \
--auth-domain local

sleep 2s

# docker compose will stop the container from running unless we do this
# known issue and workaround
tail -f /dev/null
