import 'package:flutter/material.dart';

class BTClient extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('BT 客户端'),),
    body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('IPv4:端口'),
              Flexible(child: Text('144.123.94.2:51413'))
            ],
          ),
          Row(
            children: <Widget>[
              Text('	[IPv6]:端口'),
              Text('[240e:345:464:a100:d250:99ff:fe03:aa47]:51413')
            ],
          ),
          Row(
            children: <Widget>[
              Text('反向域名	'),
              Text('[240e:345:464:a100:d250:99ff:fe03:aa47]:51413')
            ],
          ),
          Row(
            children: <Widget>[
              Text('客户端版本'),
              Text('[240e:345:464:a100:d250:99ff:fe03:aa47]:51413')
            ],
          ),
          Row(
            children: <Widget>[
              Text('特征'),
              Text('[240e:345:464:a100:d250:99ff:fe03:aa47]:51413')
            ],
          ),
          Row(
            children: <Widget>[
              Text('	做种数量'),
              Text('[240e:345:464:a100:d250:99ff:fe03:aa47]:51413')
            ],
          ),
          Row(
            children: <Widget>[
              Text('		下载数量	'),
              Text('[240e:345:464:a100:d250:99ff:fe03:aa47]:51413')
            ],
          ),
          Row(
            children: <Widget>[
              Text('	启动时间'),
              Text('[240e:345:464:a100:d250:99ff:fe03:aa47]:51413')
            ],
          ),
        ],
      )
  );
  
}
