import sys,os
done=lambda d,c: os.path.exists(f"src/{d}/output_{c}.md") and os.path.getsize(f"src/{d}/output_{c}.md")>0
q=[l.split() for l in open("queue.txt") if l.strip()]
todo=[x for x in q if not done(*[x[0],x[1]+".md"[:0]]) ]
n=int(sys.argv[1]) if len(sys.argv)>1 else 8
for d,c in todo[:n]: print(d,c)
print("remaining",len(todo),file=sys.stderr)
