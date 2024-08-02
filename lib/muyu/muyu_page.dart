import 'dart:math';

import 'package:first_station/muyu/animate_text.dart';
import 'package:first_station/muyu/count_panel.dart';
import 'package:first_station/models/audioOption.dart';
import 'package:first_station/models/imageOption.dart';
import 'package:first_station/models/meritRecord.dart';
import 'package:first_station/muyu/muyuAssetsImage.dart';
import 'package:first_station/muyu/options/audio_option_panel.dart';
import 'package:first_station/muyu/options/image_option_panel.dart';
import 'package:first_station/storage/db_storage/db_storage.dart';
import 'package:first_station/storage/spStorage.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class MuyuPage extends StatefulWidget {
  const MuyuPage({super.key});

  @override
  State<MuyuPage> createState() => _MuyuPageState();
}

//维护MeritRecord列表
List<MeritRecord> _records = [];
final Uuid uuid = Uuid();

//状态类来维护数据和界面的构建和更新
class _MuyuPageState extends State<MuyuPage>
    with AutomaticKeepAliveClientMixin {
  // 通过 audioOptions 列表记录音频选项对应的数据；
  final List<AudioOption> audioOptions = [
    AudioOption('音效1', 'muyu_1.mp3'),
    AudioOption('音效2', 'muyu_2.mp3'),
    AudioOption('音效3', 'muyu_3.mp3'),
  ];

  //_activeAudioIndex 表示当前激活的音频索引：
  int _activeAudioIndex = 0;

  void saveConfig() {
    SpStorage.instance.saveMuyuConfig(
        counter: _count,
        activeImageIndex: _activeImageIndex,
        activeAudioIndex: _activeAudioIndex);
  }

  //imageOptions对象表示木鱼选项的列表,_activeImageIndex表示当前激活的木鱼索引
  final List<ImageOption> imageOptions = [
    ImageOption('基础版', 'assets/images/muyu.png', 1, 3),
    ImageOption('尊享版', 'assets/images/muyu2.png', 3, 6),
  ];
  int _activeImageIndex = 0;

  int _cruValue = 0;
  AudioPool? pool;

  //1.计功德的变量,  2.点击时功德随机增加1-3,需要随机对象
  int _count = 0;
  final Random random = Random();

  void _onSelectImage(int value) {
    Navigator.of(context).pop();
    if (value == _activeImageIndex) return;
    setState(() {
      _activeImageIndex = value;
    });
  }

  String get activeAudio => audioOptions[_activeAudioIndex].str;

  void _onSelectAudio(int value) async {
    Navigator.of(context).pop();
    if (value == _activeAudioIndex) return;

    _activeAudioIndex = value;
    pool = await FlameAudio.createPool(activeAudio, maxPlayers: 1);
  }

  //激活图像 // 敲击时增加值
  String get activeImage => imageOptions[_activeImageIndex].src;

  int get KonkValue {
    int min = imageOptions[_activeImageIndex].min;
    int max = imageOptions[_activeImageIndex].max;
    return min + random.nextInt(max + 1 - min);
  }

  //点击
  void _onKnok() {
    //添加功德记录

    pool?.start();
    setState(() {
      String id = uuid.v4();
      MeritRecord _cruRecord = MeritRecord(
          id,
          DateTime.now().microsecondsSinceEpoch,
          _cruValue,
          activeImage,
          activeAudio);
      _cruValue = 1 + random.nextInt(3);
      _count += _cruRecord!.value;
      saveConfig();

      Dbstorage.instance.meritRecordDao.insert(_cruRecord!);

      _records.add(_cruRecord);
    });
  }

  @override
  void initState() {
    super.initState();
    _initAudioPool();
    _initConfig();
  }

  void _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readMuyuConfig();
    _count = config['counter'] ?? 0;
    _activeImageIndex = config['activeImageIndex'] ?? 0;
    _activeAudioIndex = config['activeAudioIndex'] ?? 0;
    _records = await Dbstorage.instance.meritRecordDao.query();
    setState(() {});
  }

  void _initAudioPool() async {
    pool = await FlameAudio.createPool('muyu_1.mp3', maxPlayers: 4);
  }

  void _onTapSwitchAudio() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return AudioOptionPanel(
            audioOptions: audioOptions,
            activeIndex: _activeAudioIndex,
            onSelect: _onSelectAudio,
          );
        });
  }

  void _onTapSwitchImage() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return ImageOptionPanel(
            imageOptions: imageOptions,
            onSelect: _onSelectImage,
            activeIndex: _activeImageIndex,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('电子木鱼'),
        actions: [IconButton(onPressed: _toHistory, icon: Icon(Icons.history))],
      ),
      body: Column(
        children: [
          Expanded(
              child: CountPanel(
                  count: _count,
                  onTapSwitchAudio: _onTapSwitchAudio,
                  onTapSwitchImage: _onTapSwitchImage)),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                MuyuAssetsImage(
                  image: activeImage, //使用激活图像
                  onTap: _onKnok,
                ),
                if (_cruValue != 0) AnimateText(text: '功德+${_cruValue}')
              ],
            ),
          )
        ],
      ),
    );
  }

  void _toHistory() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => RecordHistory(records: _records.reversed.toList())));
  }

  @override
  bool get wantKeepAlive => true;
}

class RecordHistory extends StatelessWidget {
  final List<MeritRecord> records;

  RecordHistory({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('功德记录'),
      ),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: records.length,
      ),
    );
  }

  DateFormat format = DateFormat('yyyy年MM月dd日 HH:mm:ss');

  Widget? _buildItem(BuildContext context, int index) {
    MeritRecord merit = records[index];
    String date =
        format.format(DateTime.fromMillisecondsSinceEpoch(merit.timestamp));
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: AssetImage(merit.image),
      ),
      title: Text("功德+${merit.audio}"),
      trailing: Text(
        date,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
