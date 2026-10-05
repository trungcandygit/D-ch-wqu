import json,glob,os
D='/home/user/D-ch-wqu/academic-ai-dich/AcademicAI_temp/'
import sys
n=int(sys.argv[1])
out=[]
for f in sorted(glob.glob(D+'chunk[0-9][0-9][0-9][0-9].md')):
    c=os.path.basename(f)[:-3]
    o=D+'output_'+c+'.md'
    if not(os.path.exists(o) and os.path.getsize(o)>0): out.append(c)
print(' '.join(out[:n])); print('remaining',len(out),file=sys.stderr)
