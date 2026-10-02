import json,glob,os
T=[("non-negative matrix factorization","phân rã ma trận không âm (NMF)","concept"),("NMF","NMF","model"),("singular value decomposition","phân rã giá trị kỳ dị (SVD)","concept"),
("dimensionality reduction","giảm chiều dữ liệu","concept"),("topic modeling","mô hình hóa chủ đề","concept"),("topic","chủ đề","concept"),
("sentiment analysis","phân tích cảm xúc","concept"),("sentiment","cảm xúc","concept"),("sentiment lexicon","từ điển cảm xúc","concept"),
("natural language processing","xử lý ngôn ngữ tự nhiên (NLP)","concept"),("word embeddings","nhúng từ (word embeddings)","concept"),("embedding","embedding","concept"),
("corpus","kho ngữ liệu","concept"),("token","token","concept"),("tokenization","tách token","concept"),("precision","độ chính xác (precision)","metric"),("recall","độ bao phủ (recall)","metric"),
("fine-tuning","tinh chỉnh (fine-tune)","concept"),("pre-trained language model","mô hình ngôn ngữ tiền huấn luyện","concept"),("transfer learning","học chuyển giao","concept"),
("FinBERT","FinBERT","model"),("BERT","BERT","model"),("GDELT","GDELT","dataset"),("Landsat","Landsat","dataset"),("GWR","GWR","model"),("geographically weighted regression","hồi quy trọng số địa lý (GWR)","model"),
("alternative data","dữ liệu thay thế","concept"),("time series","chuỗi thời gian","concept"),("sovereign bond","trái phiếu chính phủ","finance"),("bond spread","chênh lệch lợi suất trái phiếu","finance"),("yield","lợi suất","finance"),
("portfolio","danh mục đầu tư","finance"),("return","lợi suất","finance"),("volatility","biến động","finance"),("stock market","thị trường chứng khoán","finance"),("risk premium","phần bù rủi ro","finance"),
("overfitting","quá khớp","concept"),("training set","tập huấn luyện","concept"),("test set","tập kiểm tra","concept"),("validation set","tập xác thực","concept"),("classifier","bộ phân loại","concept"),
("machine learning","học máy","concept"),("deep learning","học sâu","concept"),("neural network","mạng nơ-ron","concept"),("loss function","hàm mất mát","concept"),("cost function","hàm chi phí","concept"),
("matrix","ma trận","concept"),("eigenvalue","giá trị riêng","concept"),("eigenvector","vector riêng","concept"),("latent semantic analysis","phân tích ngữ nghĩa tiềm ẩn","concept"),
("fake news","tin giả","concept"),("critical thinking","tư duy phản biện","concept"),("data veracity","tính xác thực của dữ liệu","concept"),("misinformation","thông tin sai lệch","concept"),
("information literacy","năng lực thông tin","concept"),("geospatial data","dữ liệu không gian địa lý","concept"),("raster data","dữ liệu raster","concept"),("vector data","dữ liệu vector","concept"),
("shapefile","shapefile","format"),("GeoJSON","GeoJSON","format"),("GIS","GIS (hệ thống thông tin địa lý)","concept"),("coordinate reference system","hệ tham chiếu tọa độ (CRS)","concept"),
("remote sensing","viễn thám","concept"),("satellite","vệ tinh","concept"),("resolution","độ phân giải","concept"),("spatial nonstationarity","tính không dừng theo không gian","concept"),
("spatial","không gian","concept"),("bandwidth","băng thông (bandwidth)","concept"),("kernel","hàm nhân (kernel)","concept"),("regression","hồi quy","concept"),("coefficient","hệ số","concept"),
("moral hazard","rủi ro đạo đức","finance"),("leverage","đòn bẩy","finance"),("systemic risk","rủi ro hệ thống","finance"),("short squeeze","ép mua (short squeeze)","finance"),("O-ring","vòng đệm O-ring","concept"),
("backtesting","kiểm định lùi (backtesting)","finance"),("limit order book","sổ lệnh giới hạn","finance"),("stance detection","phát hiện lập trường","concept"),("polarity","phân cực (polarity)","concept"),
("hyperparameter","siêu tham số","concept"),("feature","đặc trưng","concept"),("data cleaning","làm sạch dữ liệu","concept"),("bias","thiên lệch (bias)","concept"),("benchmark","chuẩn so sánh (benchmark)","concept")]
g={"version":2,"terms":[{"id":s,"source":s,"target":t,"category":c,"aliases":[],"gender":"unknown","confidence":"high","frequency":0,"evidence_refs":[],"notes":"module3-4"} for s,t,c in T],"high_frequency_top_n":20,"applied_meta_hashes":{}}
for d in glob.glob("src/*_temp"): json.dump(g,open(d+"/glossary.json","w"),ensure_ascii=False,indent=1)
