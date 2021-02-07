package com.wotuo.driver;

import android.annotation.TargetApi;
import android.app.job.JobParameters;
import android.app.job.JobService;
import android.os.Build;
import android.util.Log;

/**
 * Android 5.0+ 使用的 JobScheduler.
 */
@TargetApi(Build.VERSION_CODES.LOLLIPOP)
public class MyJobService extends JobService {
    /**
     * onStartJob()的回调在UI线程，不可执行耗时逻辑，否则可能造成ANR或者Job被强制销毁(超过8s)。并且，JobService里即便新起了线程，处理的时间也不能超过10min，否则Job将被强制销毁
     * @param params
     * @return
     */
    @Override
    public boolean onStartJob(JobParameters params) {
        Log.e("slh-MyJsonService", "MyJsonService  onStartJob 启动。。。。");
//        LogToFileUtils.write("MyJsonService  onStartJob 启动。。。。");
        return false;
    }

    @Override
    public boolean onStopJob(JobParameters params) {
        Log.e("slh-MyJsonService", "MyJsonService  onStopJob 停止。。。。");
//        LogToFileUtils.write("MyJsonService  onStopJob 停止。。。。");
        return false;
    }

    @Override
    public void onDestroy() {
        Log.e("slh-MyJsonService", "MyJsonService  onDestroy 销毁。。。。");
//        LogToFileUtils.write("MyJsonService  onDestroy 销毁。。。。");
        super.onDestroy();
    }
}