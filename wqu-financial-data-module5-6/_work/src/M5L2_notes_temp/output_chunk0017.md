## **4.4 Trích xuất và diễn giải chủ đề**

Bây giờ, chúng ta hãy xem xét các từ hàng đầu trong mỗi chủ đề để hiểu nội dung của chủ đề đó. Mục tiêu là hiểu các nội dung hay đối tượng mà năm chủ đề do NMF trích xuất đại diện.

Hãy nhớ rằng ma trận $H$ lưu trữ trọng số của mỗi từ trong mỗi chủ đề. Chúng ta muốn xác định các từ có trọng số cao nhất cho từng chủ đề, vì những từ này đại diện tốt nhất cho nội dung của chủ đề. Với mỗi chủ đề, chúng ta sẽ hiển thị $n$ từ hàng đầu có trọng số cao nhất. Điều này cho ta một cái nhìn sơ lược về đề tài của chủ đề. Dựa trên các từ hàng đầu, chúng ta sẽ cố gắng gán một nhãn hoặc cách diễn giải có ý nghĩa cho từng chủ đề. Việc này đòi hỏi kiến thức chuyên ngành và sự cân nhắc kỹ lưỡng về bối cảnh của các bài báo tin tức tài chính.

```python
# Retrieves the names of the features (words)
feature_names = vectorizer.get_feature_names_out()

# Extract top words
n_top_words = 10  # Top 10 words
for topic_idx, topic in enumerate(H):
    print(f"\nTopic {topic_idx + 1}:")
    print(" ".join([feature_names[i]
                    for i in topic.argsort()[:-n_top_words - 1:-1]]))

```

Chúng ta cũng có thể vẽ biểu đồ các từ hàng đầu của từng chủ đề để trực quan hóa tốt hơn. Trong đoạn mã sau, chúng ta vẽ 10 từ hàng đầu của mỗi chủ đề dưới dạng các biểu đồ cột con:

```python
# Set figure size
fig, axes = plt.subplots(1, nmf_model.n_components, figsize=(16, 6), sharex=True)
axes = axes.flatten()  # Convert to 1D array for easier indexing

# Plot bar subplots for each topic
for topic_idx, topic in enumerate(H):
    top_features_ind = topic.argsort()[:-n_top_words - 1:-1]
    top_features = [feature_names[i] for i in top_features_ind]
    weights = topic[top_features_ind]

    ax = axes[topic_idx]
    ax.barh(top_features, weights, height=0.5, fill='blue')
    ax.set_title(f'Topic {topic_idx + 1}', fontdict={'fontsize': 14})
    ax.invert_yaxis()
    ax.tick_params(axis='both', which='major', labelsize=12)

# Set figure attributes (title)
fig.suptitle('Top words in topics in NMF model', fontsize=20, y=0.98)
fig.tight_layout(h_pad=2.0)
plt.show()

```

Mục đích chính của đoạn mã này là hiển thị các từ hàng đầu của từng chủ đề do NMF trích xuất. Điều này giúp diễn giải các chủ đề và hiểu những nội dung hay đối tượng mà chúng đại diện.

Tại thời điểm viết bài, chúng tôi thu được các từ hàng đầu sau cho từng chủ đề (bạn có thể nhận được kết quả khác vì News API sẽ có một tập bài báo khác vào lúc bạn chạy đoạn mã này):

 - **Chủ đề 1: Microsoft Windows và các tính năng AI**

   - Từ hàng đầu: `copilot, plus, feature, new, pcs, features, search, voice, ai, windows`
   - Diễn giải: Chủ đề này dường như liên quan đến các tính năng và cải tiến mới trong Microsoft Windows, đặc biệt là những tính năng liên quan đến AI và khả năng tìm kiếm bằng giọng nói. Copilot, một trợ lý AI mới có thể xuất hiện, cũng là một nội dung nổi bật.

 - **Chủ đề 2: Các trung tâm dữ liệu và sáng kiến năng lượng của Microsoft**

   - Từ hàng đầu: `data, energy, centers, power, nuclear, ai, tech, run, microsoft, carbon`
   - Diễn giải: Chủ đề này dường như tập trung vào các trung tâm dữ liệu của Microsoft và mức tiêu thụ năng lượng của chúng. Chủ đề có thể bao gồm các thảo luận về nguồn điện, trong đó có năng lượng hạt nhân, và các sáng kiến nhằm giảm phát thải carbon. Việc sử dụng công nghệ AI trong các trung tâm dữ liệu cũng có thể là một nội dung đáng chú ý.

 - **Chủ đề 3: Các nỗ lực AR/VR của Microsoft (Hololens)**

   - Từ hàng đầu: `microsoft, windows, hololens, headsets, according, vr, update, production, uploadvr, 11`
   - Diễn giải: Chủ đề này có khả năng xoay quanh các nỗ lực về thực tế tăng cường và thực tế ảo của Microsoft, đặc biệt tập trung vào kính Hololens. Chủ đề có thể bao gồm các cập nhật về sản xuất Hololens, các tính năng mới, hoặc quan hệ hợp tác với các nền tảng liên quan đến VR như UploadVR.

 - **Chủ đề 4: Cạnh tranh trong lĩnh vực AI (Microsoft, OpenAI, Google)**

   - Từ hàng đầu: `openai, google, ai, microsoft, stay, date, financial, way, competition, amid`
   - Diễn giải: Chủ đề này xoay quanh sự cạnh tranh trong lĩnh vực trí tuệ nhân tạo, chủ yếu liên quan đến Microsoft, OpenAI và Google. Chủ đề có thể thảo luận về các khía cạnh tài chính, quan hệ đối tác chiến lược và bức tranh tổng thể của cuộc đua AI.

 - **Chủ đề 5: Microsoft Flight Simulator và trò chơi điện tử**

   - Từ hàng đầu: `flight, game, simulator, microsoft, 2024, test, based, reboot, 2020, office`
   - Diễn giải: Chủ đề này dường như liên quan đến Microsoft Flight Simulator, một trò chơi mô phỏng bay phổ biến. Chủ đề có thể bao gồm các thảo luận về bản cập nhật, tính năng mới, các giai đoạn thử nghiệm hoặc những bản phát hành tiềm năng trong tương lai. Việc xuất hiện từ "office" hơi bất thường và có thể cần thêm ngữ cảnh để hiểu mức độ liên quan của nó.


Dựa trên các diễn giải này, dưới đây là một bộ nhãn được đề xuất cho các chủ đề:

 1. Cải tiến AI trong Windows
 2. Tính bền vững của trung tâm dữ liệu
 3. Hololens và AR/VR
 4. Cạnh tranh trong ngành AI
 5. Flight Simulator và trò chơi điện tử

Các nhãn này thể hiện ngắn gọn và đầy đủ thông tin các nội dung mà từng chủ đề nắm bắt được. Hãy nhớ rằng việc diễn giải chủ đề có thể mang tính chủ quan, vì vậy các nhãn có thể được điều chỉnh dựa trên cách hiểu của riêng bạn về dữ liệu và bối cảnh.

Bằng cách phân tích cẩn thận các từ hàng đầu và xem xét bối cảnh rộng hơn, chúng ta có thể thu được những hiểu biết giá trị về các nội dung chính được thảo luận trong các bài báo tin tức tài chính liên quan đến Microsoft.
