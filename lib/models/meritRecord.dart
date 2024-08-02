class MeritRecord {
  final String id; //记录的唯一标识
  final int timestamp; //记录的时间戳
  final int value; //功德数
  final String image; //图片资源
  final String audio;

  MeritRecord(
      this.id, this.timestamp, this.value, this.image, this.audio); //音乐名称

  Map<String, dynamic> toJson() => {
        "id": id,
        "timestamp": timestamp,
        'value': value,
        "image": image,
        "audio": audio,
      };
}
