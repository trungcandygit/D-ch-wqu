## **7.3 Tạo biến ngày-giờ**
Tiếp theo, ta thấy biến ngày/giờ không chứa thông tin về tháng và năm. Do đó, chúng ta sẽ tạo một biến ngày/giờ mới để cung cấp thông tin ngày/giờ đầy đủ.

```python
# Create a new Date Time variable to contain month and year information
irene_1[["Date","Time"]] = irene_1["Date/Time"].str.split(" / ", expand = True)
irene_1["Date_Time"] = "08/" + irene_1["Date"] + "/2011/" + irene_1["Time"]
irene_1.set_index("Date_Time")
irene_1
```
