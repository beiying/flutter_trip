import 'dart:async';

typedef void OnTimerTickCallback(int millisUntilFinished);

class TimeUtil {
  Timer _timer;
  bool _isActive = false;
  int mInternal; //Timer间隔 单位毫秒，默认1000毫秒(1秒).

  // 倒计时总时间
  int mTotalTime; //单位毫秒

  OnTimerTickCallback _onTimerTickCallback;

  void setInternal(int internal) {
    if (internal <= 0) mInternal = Duration.millisecondsPerSecond;
    this.mInternal = internal;
  }

  void setTotalTime(int totalTime) {
    if (totalTime < 0) return;
    this.mTotalTime = totalTime;
  }

  void startTimer() {
    if (_isActive || mInternal <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInternal);
    _doCallback(0);
    _timer = Timer.periodic(duration, (Timer timer) {
      _doCallback(timer.tick);
    });
  }

  void startCountDown() {
    if (_isActive || mInternal <= 0 || mTotalTime <= 0) return;
    _isActive = true;
    Duration duration = Duration(milliseconds: mInternal);
    _doCallback(mTotalTime);
    _timer = Timer.periodic(duration, (timer) {
      int time = mTotalTime - mInternal;
      mTotalTime = time;
      if (time >= mInternal) {
        _doCallback(time);
      } else if (time == 0) {
        _doCallback(time);
        cancel();
      } else {
        timer.cancel();
        Future.delayed(Duration(milliseconds: time), () {
          mTotalTime = 0;
          _doCallback(0);
          cancel();
        });
      }
    });
  }

  void _doCallback(int tick) {
    if (_onTimerTickCallback != null) {
      _onTimerTickCallback(tick);
    }
  }

// 重设倒计时总时间.
  void updateTotalTime(int totalTime) {
    cancel();
    mTotalTime = totalTime;
    startCountDown();
  }

  // 取消计时器.
  void cancel() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    _isActive = false;
  }

  // set timer callback.
  void setOnTimerTickCallback(OnTimerTickCallback callback) {
    _onTimerTickCallback = callback;
  }
}
