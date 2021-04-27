NETHERMIND_SYNC_SSH_KEY: Private key for authenticating to rsync-ssh
NETHERMIND_SYNC_SERVER: Hostname of rsync-ssh server
NETHERMIND_SYNC_PORT: rsync-ssh port (default: 2828)
NETHERMIND_SYNC_FORCE: If set to `true`, will run rsync even if the nethermind_db dir contains a previous sync
NETHERMIND_SYNC_SNAP_OVERRIDE: Allows specifying a specify date-based directory to sync, instead of latest (i.e. 2021-04-21-09). Useful if latest is corrupt.

docker run --rm \
  -v nethermind-compose_nethermind:/nethermind/nethermind_db \
  -e NETHERMIND_SYNC_SSH_KEY="$(cat id_nethermind_sync)" \
  -e NETHERMIND_SYNC_SERVER=A.B.C.D

sync-nethermind
