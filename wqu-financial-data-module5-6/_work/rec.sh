#!/bin/bash
# usage: rec.sh dir...  -> record outputs + merge meta
S=~/.claude/skills/translate-book/scripts
for d in "$@"; do
  ids=$(ls src/$d/output_chunk*.md 2>/dev/null | sed 's/.*output_//;s/\.md//' | tr '\n' ' ')
  [ -z "$ids" ] && continue
  python3 $S/run_state.py record src/$d $ids >/dev/null 2>&1 || echo "record fail $d"
  python3 $S/merge_meta.py prepare-merge src/$d > /tmp/pm.json 2>/dev/null
  python3 - <<P
import json
d=json.load(open('/tmp/pm.json'))
json.dump({'auto_apply':d['auto_apply'],'decisions':[],'consumed_chunk_ids':d['consumed_chunk_ids']},open('/tmp/am.json','w'))
P
  python3 $S/merge_meta.py apply-merge src/$d < /tmp/am.json >/dev/null 2>&1 || echo "merge note $d (decisions pending?)"
done
