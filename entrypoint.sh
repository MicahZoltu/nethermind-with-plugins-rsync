#!/bin/sh
set -e

NETHERMIND_DATA_DIR=/nethermind/nethermind_db/mainnet
LAUNCH_NETHERMIND="exec ./Nethermind.Runner"
SSH_CMD="ssh -i $NETHERMIND_SYNC_SSH_KEY_PATH -o StrictHostKeyChecking=no -p $NETHERMIND_SYNC_PORT"

if [ -d "$NETHERMIND_DATA_DIR" ] && [ "$NETHERMIND_SYNC_FORCE" != "true" ]; then
	echo "Data directory already exists and NETHERMIND_SYNC_FORCE != true"
	$LAUNCH_NETHERMIND
fi

if [ "$NETHERMIND_SYNC_SNAP_OVERRIDE" = "" ]; then
	SNAPSHOT=`$SSH_CMD nethermind@$NETHERMIND_SYNC_SERVER ls -1 /nethermind | tail -n 1`
	echo "Fetching newest snapshot: $SNAPSHOT"
else
	SNAPSHOT=$NETHERMIND_SYNC_SNAP_OVERRIDE
	echo "Fetching override snapshot: $SNAPSHOT"
fi

rsync -av --delete -e "$SSH_CMD" nethermind@$NETHERMIND_SYNC_SERVER:/nethermind/$SNAPSHOT/mainnet/ $NETHERMIND_DATA_DIR

echo "rsync complete, launching Nethermind"
$LAUNCH_NETHERMIND
