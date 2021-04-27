* NETHERMIND_SYNC_SERVER: Hostname of rsync-ssh server (required)
* NETHERMIND_SYNC_PORT: rsync-ssh port (default: 2828)
* NETHERMIND_SYNC_SSH_KEY_PATH: Path in container where SSH key is located (default: /run/secrets/rsync_ssh_key)
* NETHERMIND_SYNC_FORCE: If set to `true`, will run rsync even if the nethermind_db dir contains a previous sync (default: false)
* NETHERMIND_SYNC_SNAP_OVERRIDE: Allows specifying a specify date-based directory to sync, instead of latest (i.e. 2021-04-21-09). Useful if latest is corrupt. (default: unset)

```bash
cat ~/.ssh/id_rsa | docker secret create rsync_ssh_key -
docker service create \
  --name nethermind \
  --secret source=rsync_ssh_key,mode=0600 \
  --mount type=volume,source=nethermind-compose_nethermind,destination=/nethermind/nethermind_db \
  --env NETHERMIND_SYNC_SERVER=A.B.C.D \
  docker pull ghcr.io/micahzoltu/nethermind-with-plugins-rsync:1.10.56-6.0.1-3.0.1-1
```
