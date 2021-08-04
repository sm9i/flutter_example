import 'dart:ui';

import 'package:flutter/material.dart';

import 'emoji_model.dart';
import 'dart:math' as math;

class EmojiWidget extends StatefulWidget {
  final double height;
  final bool active;

  const EmojiWidget({Key? key, required this.active, required this.height})
      : super(key: key);

  static int get padGridCount => 7;

  @override
  _EmojiWidgetState createState() => _EmojiWidgetState();
}

class _EmojiWidgetState extends State<EmojiWidget> {
  @override
  Widget build(BuildContext context) {
    final double _height = math.max(
        MediaQuery.of(context).size.width / EmojiWidget.padGridCount * 4,
        widget.height);
    return Container(
      height: widget.active ? _height : 0,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Center(
                child: RepaintBoundary(
                  child: Image.asset(
                    emojis[index].path,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width /
                        EmojiWidget.padGridCount /
                        2,
                  ),
                ),
              );
            }, childCount: emojis.length),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.25,
              crossAxisCount: EmojiWidget.padGridCount,
            ),
          ),
        ],
      ),
    );
  }
}

const List<EmojiModel> emojis = <EmojiModel>[
  EmojiModel(name: 'doge', fileName: 'doge'),
  EmojiModel(name: '滑稽', fileName: 'huaji'),
  EmojiModel(name: '666', fileName: '666'),
  EmojiModel(name: '暗中观察', fileName: 'anzhongguancha'),
  EmojiModel(name: '沧桑', fileName: 'cangsang'),
  EmojiModel(name: '打脸', fileName: 'dalian'),
  EmojiModel(name: '机智', fileName: 'jizhi'),
  EmojiModel(name: '防疫', fileName: 'fangyi'),
  EmojiModel(name: '笑哭', fileName: 'xiaoku'),
  EmojiModel(name: '捂脸', fileName: 'wulian'),
  EmojiModel(name: '苦涩', fileName: 'kuse'),
  EmojiModel(name: '摸鱼', fileName: 'moyu'),
  EmojiModel(name: '柠檬', fileName: 'ningmeng'),
  EmojiModel(name: '压岁钱', fileName: 'yasuiqian'),
  EmojiModel(name: '福字', fileName: 'fuzi'),
  EmojiModel(name: '灯笼', fileName: 'denglong'),
  EmojiModel(name: '烟火', fileName: 'yanhuo'),
  EmojiModel(name: '鞭炮', fileName: 'bianpao'),
  EmojiModel(name: '微笑', text: '微笑2', fileName: 'weixiao2'),
  EmojiModel(name: '撇嘴', text: '撇嘴1', fileName: 'piezui1'),
  EmojiModel(name: '色', text: '色4', fileName: 'se4'),
  EmojiModel(name: '发呆', text: '发呆2', fileName: 'fadai2'),
  EmojiModel(name: '得意', text: '得意1', fileName: 'deyi1'),
  EmojiModel(name: '流泪', text: '流泪2', fileName: 'liulei2'),
  EmojiModel(name: '害羞', text: '害羞5', fileName: 'haixiu5'),
  EmojiModel(name: '闭嘴', text: '闭嘴1', fileName: 'bizui1'),
  EmojiModel(name: '睡', fileName: 'shui'),
  EmojiModel(name: '大哭', text: '大哭7', fileName: 'daku7'),
  EmojiModel(name: '尴尬', text: '尴尬1', fileName: 'ganga1'),
  EmojiModel(name: '发怒', fileName: 'fanu'),
  EmojiModel(name: '调皮', text: '调皮1', fileName: 'tiaopi1'),
  EmojiModel(name: '呲牙', fileName: 'ciya'),
  EmojiModel(name: '惊讶', text: '惊讶4', fileName: 'jingya4'),
  EmojiModel(name: '难过', fileName: 'nanguo'),
  EmojiModel(name: '酷', fileName: 'ku'),
  EmojiModel(name: '冷汗', fileName: 'lenghan'),
  EmojiModel(name: '抓狂', fileName: 'zhuakuang'),
  EmojiModel(name: '吐', fileName: 'tu'),
  EmojiModel(name: '偷笑', text: '偷笑2', fileName: 'touxiao2'),
  EmojiModel(name: '可爱', text: '可爱1', fileName: 'keai1'),
  EmojiModel(name: '白眼', text: '白眼1', fileName: 'baiyan1'),
  EmojiModel(name: '傲慢', fileName: 'aoman'),
  EmojiModel(name: '饥饿', text: '饥饿2', fileName: 'jie2'),
  EmojiModel(name: '困', fileName: 'kun'),
  EmojiModel(name: '惊恐', text: '惊恐1', fileName: 'jingkong1'),
  EmojiModel(name: '流汗', text: '流汗2', fileName: 'liuhan2'),
  EmojiModel(name: '憨笑', fileName: 'hanxiao'),
  EmojiModel(name: '大兵', fileName: 'dabing'),
  EmojiModel(name: '奋斗', text: '奋斗1', fileName: 'fendou1'),
  EmojiModel(name: '咒骂', fileName: 'zhouma'),
  EmojiModel(name: '疑问', text: '疑问2', fileName: 'yiwen2'),
  EmojiModel(name: '嘘', fileName: 'xu'),
  EmojiModel(name: '晕', text: '晕3', fileName: 'yun3'),
  EmojiModel(name: '折磨', text: '折磨1', fileName: 'zhemo1'),
  EmojiModel(name: '衰', text: '衰1', fileName: 'shuai1'),
  EmojiModel(name: '骷髅', fileName: 'kulou'),
  EmojiModel(name: '敲打', fileName: 'qiaoda'),
  EmojiModel(name: '再见', fileName: 'zaijian'),
  EmojiModel(name: '擦汗', fileName: 'cahan'),
  EmojiModel(name: '抠鼻', fileName: 'koubi'),
  EmojiModel(name: '鼓掌', text: '鼓掌1', fileName: 'guzhang1'),
  EmojiModel(name: '糗大了', fileName: 'qiudale'),
  EmojiModel(name: '坏笑', text: '坏笑1', fileName: 'huaixiao1'),
  EmojiModel(name: '左哼哼', fileName: 'zuohengheng'),
  EmojiModel(name: '右哼哼', fileName: 'youhengheng'),
  EmojiModel(name: '哈欠', fileName: 'haqian'),
  EmojiModel(name: '鄙视', text: '鄙视2', fileName: 'bishi2'),
  EmojiModel(name: '委屈', text: '委屈1', fileName: 'weiqu1'),
  EmojiModel(name: '快哭了', fileName: 'kuaikule'),
  EmojiModel(name: '阴险', fileName: 'yinxian'),
  EmojiModel(name: '亲亲', fileName: 'qinqin'),
  EmojiModel(name: '吓', fileName: 'xia'),
  EmojiModel(name: '可怜', text: '可怜2', fileName: 'kelian2'),
  EmojiModel(name: '菜刀', fileName: 'caidao'),
  EmojiModel(name: '西瓜', fileName: 'xigua'),
  EmojiModel(name: '啤酒', fileName: 'pijiu'),
  EmojiModel(name: '篮球', fileName: 'lanqiu'),
  EmojiModel(name: '乒乓', fileName: 'pingpang'),
  EmojiModel(name: '咖啡', fileName: 'kafei'),
  EmojiModel(name: '饭', fileName: 'fan'),
  EmojiModel(name: '猪头', fileName: 'zhutou'),
  EmojiModel(name: '玫瑰', fileName: 'meigui'),
  EmojiModel(name: '凋谢', fileName: 'diaoxie'),
  EmojiModel(name: '示爱', fileName: 'shiai'),
  EmojiModel(name: '爱心', fileName: 'aixin'),
  EmojiModel(name: '心碎', fileName: 'xinsui'),
  EmojiModel(name: '蛋糕', fileName: 'dangao'),
  EmojiModel(name: '闪电', fileName: 'shandian'),
  EmojiModel(name: '炸弹', fileName: 'zhadan'),
  EmojiModel(name: '刀', fileName: 'dao'),
  EmojiModel(name: '足球', fileName: 'zuqiu'),
  EmojiModel(name: '瓢虫', fileName: 'piaochong'),
  EmojiModel(name: '便便', fileName: 'bianbian'),
  EmojiModel(name: '月亮', fileName: 'yueliang'),
  EmojiModel(name: '太阳', fileName: 'taiyang'),
  EmojiModel(name: '礼物', fileName: 'liwu'),
  EmojiModel(name: '拥抱', fileName: 'yongbao'),
  EmojiModel(name: '强', fileName: 'qiang'),
  EmojiModel(name: '弱', fileName: 'ruo'),
  EmojiModel(name: '握手', fileName: 'woshou'),
  EmojiModel(name: '胜利', fileName: 'shengli'),
  EmojiModel(name: '抱拳', fileName: 'baoquan'),
  EmojiModel(name: '勾引', fileName: 'gouyin'),
  EmojiModel(name: '拳头', fileName: 'quantou'),
  EmojiModel(name: '差劲', fileName: 'chajin'),
  EmojiModel(name: '爱你', fileName: 'aini'),
  EmojiModel(name: 'NO', fileName: 'NO'),
  EmojiModel(name: 'OK', fileName: 'OK'),
  EmojiModel(name: '爱情', fileName: 'aiqing'),
  EmojiModel(name: '飞吻', text: '飞吻1', fileName: 'feiwen1'),
  EmojiModel(name: '跳跳', fileName: 'tiaotiao'),
  EmojiModel(name: '发抖', fileName: 'fadou'),
  EmojiModel(name: '怄火', fileName: 'ouhuo'),
  EmojiModel(name: '转圈', fileName: 'zhuanquan'),
  EmojiModel(name: '磕头', fileName: 'ketou'),
  EmojiModel(name: '回头', fileName: 'huitou'),
  EmojiModel(name: '跳绳', fileName: 'tiaosheng'),
  EmojiModel(name: '挥手', fileName: 'zaijian'),
  EmojiModel(name: '激动', text: '激动3', fileName: 'jidong3'),
  EmojiModel(name: '街舞', fileName: 'jiewu'),
  EmojiModel(name: '献吻', fileName: 'xianwen'),
  EmojiModel(name: '左太极', fileName: 'zuotaiji'),
  EmojiModel(name: '右太极', fileName: 'youtaiji'),
];
