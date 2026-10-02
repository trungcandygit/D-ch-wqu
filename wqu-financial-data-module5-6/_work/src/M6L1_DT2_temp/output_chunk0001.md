# M6L1_DT2

## Shapefiles / Dữ liệu không gian địa lý

Hướng dẫn tìm hiểu, tìm kiếm và sử dụng shapefile.

### Shapefile là gì?

Shapefile (SHP) là định dạng lưu trữ dữ liệu vector, dùng để lưu vị trí, hình dạng và thuộc tính của các đối tượng địa lý. Định dạng này do ESRI phát triển nên đôi khi được gọi là "ESRI shapefile". Shapefile là loại tệp GIS (hệ thống thông tin địa lý) phổ biến nhất và hiện được chấp nhận làm định dạng chuẩn của toàn ngành.

Định dạng shapefile mô tả hình học và thuộc tính của các đối tượng có tham chiếu địa lý trong ba tệp trở lên với các phần mở rộng riêng, và các tệp này cần được lưu trong cùng một không gian làm việc của dự án.

Có ba tệp bắt buộc:

- .shp là tệp Esri bắt buộc, cung cấp hình học cho các đối tượng. Mỗi shapefile có một tệp .shp riêng chứa dữ liệu vector không gian, chẳng hạn điểm, đường và đa giác trên bản đồ.
- .shx là tệp chỉ mục vị trí hình dạng bắt buộc của Esri và AutoCAD, dùng để tìm kiếm tiến và lùi.
- .dbf là tệp cơ sở dữ liệu chuẩn, dùng để lưu dữ liệu thuộc tính và mã định danh đối tượng (object ID). Tệp .dbf là bắt buộc đối với shapefile và có thể mở bằng Microsoft Access hoặc Excel.

Để có mô tả đầy đủ hơn về định dạng shapefile, xem ESRI White Paper (tháng 7/1998): ESRI Shapefile Technical Description.
