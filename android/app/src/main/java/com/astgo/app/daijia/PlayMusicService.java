package com.wotuo.driver;

import android.app.AlarmManager;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.app.job.JobInfo;
import android.app.job.JobScheduler;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.core.app.NotificationCompat;

/**
 * 后台播放无声音乐
 */
public class PlayMusicService extends Service {
    private boolean mNeedStop = false; //控制是否播放音频
    private MediaPlayer mMediaPlayer;
    NotificationManager mNotificationManager;

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        mNotificationManager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
        startForeground(111, getNotification(this, "标兵代驾后台运行中", "slh_demo", mNotificationManager));
        mMediaPlayer = MediaPlayer.create(getApplicationContext(), R.raw.kongyin);
        mMediaPlayer.setLooping(true);
        mMediaPlayer.setOnBufferingUpdateListener(new MediaPlayer.OnBufferingUpdateListener() {
            @Override
            public void onBufferingUpdate(MediaPlayer mp, int percent) {
                Log.e("slh-PlayMusicService", "----> stopPlayMusic ,停止服务");
            }
        });
        startJobAlarmSub();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        stopPlayMusic();
        cancelJobAlarmSub();
        Log.e("slh-PlayMusicService", "----> stopPlayMusic ,停止服务");
        // 重启自己
//        if (!mNeedStop) {
//            Log.e("slh-PlayMusicService", "----> PlayMusic ,重启服务");
//            Intent intent = new Intent(getApplicationContext(), PlayMusicService.class);
//            startService(intent);
//        }
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
//        LogToFileUtils.write("PlayMusicService  onStartCommand 启动。。。。");
        startPlayMusic();
        return START_STICKY;
    }

    public static void startService(Context context) {
        Intent intent = new Intent(context, PlayMusicService.class);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(intent);
        } else {
            context.startService(intent);
        }
    }

    public static void stopService(Context context) {
        Intent intent = new Intent(context, PlayMusicService.class);
        context.stopService(intent);
    }


    private void startPlayMusic() {
        if (mMediaPlayer != null && !mMediaPlayer.isPlaying() && !mNeedStop) {
            Log.e("slh-PlayMusicService", "开始后台播放音乐");
            mMediaPlayer.start();
        }
    }

    private void stopPlayMusic() {
        if (mMediaPlayer != null) {
            Log.e("slh-PlayMusicService", "关闭后台播放音乐");
            mMediaPlayer.stop();
        }
    }


    /**
     * 停止自己
     */
    private void stopService() {
        mNeedStop = true;
        stopPlayMusic();
        stopSelf();
    }

    protected final int HASH_CODE = 11222;
    protected PendingIntent mPendingIntent;

    public void startJobAlarmSub() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            JobInfo.Builder builder = new JobInfo.Builder(HASH_CODE,new ComponentName(this, MyJobService.class));
            builder.setPeriodic(60 * 1000);
            //Android 7.0+ 增加了一项针对 JobScheduler 的新限制，最小间隔只能是下面设定的数字
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
                builder.setPeriodic(JobInfo.getMinPeriodMillis(), JobInfo.getMinFlexMillis());
            }
            builder.setPersisted(true);
            JobScheduler scheduler = (JobScheduler) getSystemService(Context.JOB_SCHEDULER_SERVICE);
            scheduler.schedule(builder.build());
        } else {
            //Android 4.4- 使用 AlarmManager
            AlarmManager am = (AlarmManager) getSystemService(ALARM_SERVICE);
            Intent i = new Intent(this, PlayMusicService.class);
            mPendingIntent = PendingIntent.getService(this, HASH_CODE, i, PendingIntent.FLAG_UPDATE_CURRENT);
            am.setRepeating(AlarmManager.RTC_WAKEUP,
                    System.currentTimeMillis() + 60 * 1000,
                    60 * 1000, mPendingIntent);
        }
    }

    /**
     * 用于在不需要服务运行的时候取消 Job / Alarm
     */
    private void cancelJobAlarmSub() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            JobScheduler scheduler = (JobScheduler) this.getSystemService(JOB_SCHEDULER_SERVICE);
            scheduler.cancel(HASH_CODE);
        } else {
            AlarmManager am = (AlarmManager) this.getSystemService(ALARM_SERVICE);
            if (mPendingIntent != null) {
                am.cancel(mPendingIntent);
            }
        }
    }

    /**
     * 通知栏显示
     * //将此通知放到通知栏的"Ongoing"即"正在运行"组中
     * n.flags |= Notification.FLAG_ONGOING_EVENT;
     * //表明在点击了通知栏中的"清除通知"后，此通知不清除
     * n.flags |= Notification.FLAG_NO_CLEAR;
     */
    private Notification getNotification(Context context, String title, String notificationChannel, NotificationManager nm) {

        String notificationName = "notification";

        // 适配8.0
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            // 通知渠道
            NotificationChannel channel = new NotificationChannel(notificationChannel, notificationName, NotificationManager.IMPORTANCE_HIGH);

            channel.enableLights(false); // 是否在桌面icon右上角展示小红点
            channel.setShowBadge(false); // 是否在久按桌面图标时显示此渠道的通知
            channel.enableVibration(false);
            channel.setSound(null, null);
            // 最后在notificationmanager中创建该通知渠道
            nm.createNotificationChannel(channel);
        }

        Notification.Builder builder = new Notification.Builder(context);

        builder.setDefaults(NotificationCompat.FLAG_ONLY_ALERT_ONCE);//统一消除声音和震动

        //NotificationCompat.Builder builder = new NotificationCompat.Builder(context);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            builder.setChannelId(notificationChannel);
        }

        builder.setContentTitle(title);
        builder.setSmallIcon(R.drawable.ic_launcher);
        //builder.setProgress(100, progress, false);

        try {
            Intent intent = new Intent(context, NotificationClickReceiver.class);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent, 0);
            builder.setContentIntent(pendingIntent);
        } catch (Exception e) {
            Log.e("PendingIntent", e.getMessage());
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            builder.setShowWhen(false);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT_WATCH) {
            builder.setLocalOnly(true);
        }
        Notification notification = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
            notification = builder.build();
        } else {
            notification = builder.getNotification();
        }
        notification.flags |= Notification.FLAG_NO_CLEAR;
        return notification;
    }


}