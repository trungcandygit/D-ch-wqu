import json,sys,os,re,base64,subprocess
from bs4 import BeautifulSoup
SRC="/home/user/D-ch-wqu/Lession 5,6 tài liệu/"
OUT="/home/user/D-ch-wqu/wqu-financial-data-module5-6/_work/src/"
BAD=re.compile(r"Traceback|Error|Warning|warn|login|authenticat|HTTPError|Unauthorized|KeyError",re.I)
def md_from_nb(path,name):
    nb=json.load(open(path)); out=[]; n=0
    imgdir=OUT+name+"_img/"; os.makedirs(imgdir,exist_ok=True)
    def save(b64,ext):
        nonlocal n; n+=1; fn=f"{name}_img/img{n:03d}.{ext}"
        open(OUT+fn,"wb").write(base64.b64decode(b64)); return fn
    for c in nb["cells"]:
        s="".join(c["source"])
        att=c.get("attachments",{})
        for k,v in att.items():
            mt,b=next(iter(v.items())); s=s.replace(f"attachment:{k}",save(b,mt.split('/')[1].split('+')[0]))
        if c["cell_type"]=="markdown": out.append(s)
        elif c["cell_type"]=="code":
            out.append("```python\n"+s+"\n```")
            for o in c.get("outputs",[]):
                t=o.get("output_type")
                if t in("error",): continue
                if t=="stream":
                    if o.get("name")=="stderr": continue
                    tx="".join(o["text"])
                    if BAD.search(tx) or len(tx)>3000: continue
                    out.append("Output:\n```\n"+tx.rstrip()+"\n```")
                elif t in("display_data","execute_result"):
                    d=o["data"]
                    for mt in("image/png","image/jpeg"):
                        if mt in d: out.append(f"![]({save(d[mt],mt.split('/')[1])})"); break
                    else:
                        if "text/plain" in d:
                            tx="".join(d["text/plain"])
                            if len(tx)<2500 and not BAD.search(tx): out.append("Output:\n```\n"+tx.rstrip()+"\n```")
    open(OUT+name+".md","w").write("\n\n".join(out)); 
def md_from_html(path,name):
    soup=BeautifulSoup(open(path,errors="ignore"),"html.parser")
    for t in soup(["script","style"]): t.decompose()
    imgdir=OUT+name+"_img/"; os.makedirs(imgdir,exist_ok=True); n=0
    for im in soup.find_all("img"):
        src=im.get("src","")
        if src.startswith("data:image"):
            n+=1; ext=src.split(";")[0].split("/")[1].split("+")[0]
            open(f"{imgdir}img{n:03d}.{ext}","wb").write(base64.b64decode(src.split(",",1)[1])); im["src"]=f"{name}_img/img{n:03d}.{ext}"
    # drop error / stderr outputs
    for o in soup.select(".jp-RenderedText[data-mime-type='application/vnd.jupyter.stderr'],.output_stderr,.jp-OutputArea-output[data-mime-type='application/vnd.jupyter.stderr']"): o.decompose()
    for o in soup.select(".ansi-red-fg"): 
        p=o.find_parent(class_=re.compile("jp-OutputArea-child|output_area")); 
        if p: p.decompose()
    open(OUT+name+".html","w").write(str(soup))
if __name__=="__main__":
    for kind,p,name in [("nb","lession note M5/5.2","M5L2_notes"),("nb","Lession note m6/m6.1","M6L1_notes"),("nb","Lession note m6/m6.l2","M6L2_notes"),("nb","Lession note m6/M6.l3","M6L3_notes"),
        ("html","lession note M5/5.1.html","M5L1_notes"),("html","lession note M5/5.3.html","M5L3_notes"),("html","Lession note m6/M6 L4 .html","M6L4_notes")]:
        (md_from_nb if kind=="nb" else md_from_html)(SRC+p,name)
