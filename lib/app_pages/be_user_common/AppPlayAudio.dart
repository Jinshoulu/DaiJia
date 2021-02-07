
import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AppPlayAudio {

  static final AppPlayAudio instance = AppPlayAudio.init();

  factory AppPlayAudio() => instance;


  AudioPlayer _audioPlayer;
  AudioCache _audioCache;
  AudioPlayerState _AudioPlayerState = AudioPlayerState.STOPPED;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;
  StreamSubscription  mStreamSubscription;
  String currentPlayerAudioUrl = '';

  AppPlayAudio.init(){
    print('222 00000000 333');
    if(_audioPlayer==null){
      print('1313213232132131');
      _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
      if (Platform.isIOS) {
        if (_audioCache.fixedPlayer != null) {
          _audioCache.fixedPlayer.startHeadlessService();
        }
        _audioPlayer.startHeadlessService();
      }
      _audioCache = AudioCache(fixedPlayer: _audioPlayer);
      _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
        // TODO implemented for iOS, waiting for android impl
        if (Platform.isIOS) {
          // (Optional) listen for notification updates in the background
          _audioPlayer.startHeadlessService();
        }
      });

      _positionSubscription =
          _audioPlayer.onAudioPositionChanged.listen((p){
            debugPrint('audioPlayer onAudioPositionChanged $p');
          });

      _playerCompleteSubscription =
          _audioPlayer.onPlayerCompletion.listen((event) {
            debugPrint('audioPlayer onPlayerCompletion ');
            _audioPlayer.stop();
            _AudioPlayerState = AudioPlayerState.STOPPED;
          });

      _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
        debugPrint('audioPlayer error : $msg');
        _AudioPlayerState = AudioPlayerState.STOPPED;
        _audioPlayer.stop();
      });

      _audioPlayer.onPlayerStateChanged.listen((state) {
        debugPrint('audioPlayer onPlayerStateChanged $state');
        _AudioPlayerState = state;
      });
      _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
        debugPrint('audioPlayer onNotificationPlayerStateChanged $state');
      });
    }

  }

  ///销毁播放器
  Future disAudioPlayer()async {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    await _audioPlayer.release();
    debugPrint('收到关闭语音的消息了3');
    _audioPlayer.dispose();
  }

  ///使用播放器播放
  Future play(String url) async {

    if(_AudioPlayerState==AudioPlayerState.PLAYING){
      debugPrint('有音频正在播放');
      return;
    }
    if (url == null || url.isEmpty) {
      return;
    }
    debugPrint("音频路径：${url + "-------------------"} \n 保存的路径 = $url");

    _audioCache.play(url);

//    if(url.contains('http')){
//      _audioPlayer.play(url);
//    }else{
//      _audioPlayer.play(url);
//    }
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);

  }

  ///播放器暂停
  Future<int> pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) {}
    return result;
  }

  ///设置外音
  Future setPlayState() async {
    //  "status5": "2",//使用听筒播放语音：1开启2关闭，默认为2
    int result = await _audioPlayer.earpieceOrSpeakersToggle();
    debugPrint("当前模式后： $result");
    return result;
  }

}
