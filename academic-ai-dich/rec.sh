#!/bin/bash
cd /home/user/D-ch-wqu/academic-ai-dich; S=/root/.claude/skills/translate-book/scripts; D=AcademicAI_temp
ids=$(ls $D/output_chunk[0-9][0-9][0-9][0-9].md 2>/dev/null | xargs -n1 basename | sed 's/output_//;s/\.md//' | while read c; do [ -s $D/output_$c.md ] && echo $c; done)
python3 $S/run_state.py record $D $ids >/dev/null 2>&1
python3 $S/merge_meta.py prepare-merge $D > /tmp/pm.json 2>/dev/null
python3 - <<'P'
import json,subprocess
d=json.load(open('/tmp/pm.json'))
if d.get('consumed_chunk_ids'):
    p={"auto_apply":d.get('auto_apply',[]),"decisions":[],"consumed_chunk_ids":d['consumed_chunk_ids']}
    subprocess.run(['python3','/root/.claude/skills/translate-book/scripts/merge_meta.py','apply-merge','/home/user/D-ch-wqu/academic-ai-dich/AcademicAI_temp'],input=json.dumps(p),text=True,capture_output=True)
P
