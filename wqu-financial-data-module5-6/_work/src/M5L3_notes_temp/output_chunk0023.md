## **3.4 Cách nâng cao phân tích cảm xúc**

Bên cạnh cột `V2Tone`, bộ dữ liệu GDELT GKG 2.0 còn có các cột khác mà ta có thể tận dụng để nâng cao phân tích cảm xúc (sentiment analysis):

**Themes và V2Themes:** Các cột này chứa danh sách các chủ đề được nhận diện trong bài báo. Ta có thể dùng chúng để xác định các chủ đề liên quan đến cảm xúc tích cực hoặc tiêu cực (ví dụ: "ECON_INFLATION" có thể gắn với cảm xúc tiêu cực). Ta có thể xây dựng một từ điển ánh xạ các chủ đề sang điểm cảm xúc và dùng nó để phân tích cảm xúc gắn với các chủ đề xuất hiện trong các bài báo.

Ta có thể dùng các cột này để tạo một từ điển cảm xúc hoặc bộ từ vựng (lexicon) dựa trên sự đồng xuất hiện của các chủ đề cụ thể với những từ khóa tích cực hoặc tiêu cực. Sau đó, ta có thể dùng bộ từ vựng này để chấm điểm cảm xúc của các bài báo dựa trên sự hiện diện của các chủ đề hoặc tên riêng đó.

**Quotations:** Cột này chứa các trích dẫn trực tiếp từ bài báo. Việc phân tích cảm xúc của các trích dẫn này có thể mang lại sự hiểu biết sắc thái hơn về cảm xúc được thể hiện trong bài báo. Ta có thể áp dụng trực tiếp các kỹ thuật phân tích cảm xúc lên văn bản của các trích dẫn để hiểu chi tiết hơn về cảm xúc được thể hiện.

**GCAM:** GCAM là viết tắt của Global Content Analysis Measures (các thước đo phân tích nội dung toàn cầu). Cột này trong bộ dữ liệu GKG cung cấp một tập hợp toàn diện các thước đo phân tích nội dung, được suy ra từ việc áp dụng Google Cloud Vision API lên các hình ảnh và video đi kèm một bài báo. Cột này chứa kết quả đầu ra của Google Cloud Vision API, có thể bao gồm các nhãn và mô tả của hình ảnh gắn với bài báo. Đôi khi, các nhãn và mô tả này gợi ra manh mối về cảm xúc của bài báo. Ta có thể áp dụng phân tích cảm xúc lên văn bản trích xuất từ dữ liệu GCAM để suy ra cảm xúc liên quan đến nội dung trực quan của bài báo.

Ta có thể trích xuất văn bản từ dữ liệu GCAM và áp dụng các mô hình phân tích cảm xúc lên văn bản này để suy ra cảm xúc gắn với nội dung trực quan.

**AllNames:** Cột này chứa danh sách tất cả các tên được nhắc đến trong bài báo. Cột này có thể được dùng để xác định các cá nhân hoặc tổ chức thường xuyên gắn với cảm xúc tích cực hoặc tiêu cực. Bằng cách phân tích cảm xúc gắn với các tên được nhắc đến, ta có thể xác định những tác nhân có ảnh hưởng hoặc các bên liên quan then chốt đang chi phối cảm xúc chung.

Những lưu ý quan trọng: So với cột `V2Tone`, các cột này có thể đòi hỏi nhiều bước tiền xử lý và phân tích hơn. Ngoài ra, độ chính xác của phân tích cảm xúc dựa trên các cột này có thể thấp hơn so với dùng `V2Tone`, vốn được thiết kế riêng cho phân tích cảm xúc. Việc kết hợp những hiểu biết từ các cột này với dữ liệu `V2Tone` có thể mang lại cái nhìn toàn diện hơn về cảm xúc chung.
