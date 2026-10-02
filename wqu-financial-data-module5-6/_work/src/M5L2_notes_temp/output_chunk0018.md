## **4.5 Gán chủ đề cho tài liệu**

Bây giờ, chúng ta sẽ dùng `W` để gán chủ đề nổi bật nhất cho từng tài liệu. Ta có thể thực hiện bằng cách tìm chủ đề (cột) có trọng số cao nhất đối với mỗi tài liệu (hàng) trong `W`:

```python
# Assigns the dominant topic for each document
df['Dominant_Topic'] = W.argmax(axis=1) + 1  # +1 to start topic numbering from 1

```

Ở đây, `W.argmax(axis=1)` tìm chỉ số của giá trị lớn nhất (trọng số cao nhất) trong mỗi hàng của $W$. Chỉ số này tương ứng với chủ đề chiếm ưu thế của tài liệu đó. Còn `+ 1` cộng thêm 1 vào chỉ số chủ đề để việc đánh số chủ đề bắt đầu từ 1 thay vì 0 (mặc định trong cách đánh chỉ số của Python).

Biểu đồ cột có thể được dùng để trực quan hóa phân phối các chủ đề trong từng tài liệu riêng lẻ hoặc trên toàn bộ kho ngữ liệu. Biểu đồ cột sau đây thể hiện phân phối chủ đề trung bình trên tất cả các tài liệu:

```python
# Visualize average topic distribution across all documents
avg_topic_distribution = W.mean(axis=0)

# Define topic labels
topic_labels = ["Windows AI Enhancements", "Data Center Sustainability",
                "Hololens and AR/VR", "AI Industry Competition",
                "Flight Simulator and Gaming"]

# Create bar plot
bars = plt.bar(np.arange(nmf_model.n_components) + 1, avg_topic_distribution, color='skyblue')

# Add bar labels inside bars
for bar, label in zip(bars, topic_labels):
    plt.text(bar.get_x() + bar.get_width() / 2, bar.get_height() / 2, label,
             ha='center', va='center', rotation=90, color='black', fontsize=8)

plt.xticks(np.arange(nmf_model.n_components) + 1)
plt.xlabel("Topic")
plt.ylabel("Average Weight")
plt.title("Average Topic Distribution Across All Documents")
plt.show()

```

Biểu đồ cột này minh họa mức độ phổ biến trung bình của từng chủ đề trên tất cả các tài liệu trong tập dữ liệu. Chiều cao của mỗi cột biểu thị trọng số trung bình, hay mức độ quan trọng, của chủ đề đó trên toàn bộ các tài liệu được phân tích. Cột càng cao cho thấy chủ đề đó càng nổi bật hoặc được đề cập thường xuyên hơn xét trên tổng thể.

Dựa vào chiều cao của các cột tương ứng, ta có thể thấy "AI Industry Competition" là chủ đề phổ biến nhất, tiếp theo là "Hololens and AR/VR".

Thông qua việc xem xét trực quan hóa này, chúng ta có thể hiểu rõ hơn về phân bố chủ đề tổng thể trong tập dữ liệu. Thông tin này sẽ định hướng cho các phân tích tiếp theo, chẳng hạn tập trung vào các tài liệu liên quan đến "AI Industry Competition" và "Hololens and AR/VR" để hiểu sâu hơn về những chủ đề chủ đạo này.
