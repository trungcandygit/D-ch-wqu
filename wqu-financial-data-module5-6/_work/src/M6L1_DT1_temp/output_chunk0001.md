# M6L1_DT1

# GeoJSON

GeoJSON là một định dạng dùng để mã hóa nhiều loại cấu trúc dữ liệu địa lý.

```json
{
    "type": "Feature",
    "geometry": {
      "type": "Point",
      "coordinates": [125.6, 10.1]
    },
    "properties": {
      "name": "Dinagat Islands"
    }
}
```

GeoJSON hỗ trợ các kiểu hình học sau: Point, LineString, Polygon, MultiPoint, MultiLineString và MultiPolygon. Đối tượng hình học kèm thuộc tính bổ sung là đối tượng Feature. Tập hợp các feature được chứa trong đối tượng FeatureCollection.

## Đặc tả GeoJSON (RFC 7946)

Năm 2015, Internet Engineering Task Force (IETF) phối hợp với các tác giả đặc tả gốc đã thành lập một nhóm làm việc (WG) về GeoJSON nhằm chuẩn hóa định dạng này. RFC 7946 được công bố vào tháng 8 năm 2016 và là đặc tả chuẩn mới của định dạng GeoJSON, thay thế đặc tả GeoJSON năm 2008.
