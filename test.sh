# 本地推流
ffmpeg -i 1.mp4 -c copy -f flv "rtmp://pili-publish.xinkuanvip.com/lab-live/0_6_20191223_-bNo42kNDv?e=1577094082&token=C9wQEzo1YL8nIlTASxvVTqvEZgHjCwasoTLL1mIZ:bW_c1IaLvk89hBcXwdrsr1fb164="

# 本地拉流

ffmpeg -i "https://pili-live-hls.xinkuanvip.com/lab-live/0_6_20191223_-bNo42kNDv.m3u8?t=5e01af73&sign=8ddffe7984c71d1d5d05bc718a32e1ee" -codec copy -f mp4 rr.mp4


# 上一期版本

ffmpeg -i f.jpg \
       -i 1.mp4 \
       -i long.mp4 \
       -i audio.mp3 \
       -i t.wav \
       -i sy.png \
       -filter_complex '[0]scale=720:1280,setpts=PTS+6/TB[in0];
                        [1:v]scale=720:1280[in1];
                        [2:v]scale=720:1280[in2];
                        [in0][in1][in2] concat=n=3:v=1:a=0 [v];
                        [3:a]adelay=30s|30s[a3];
                        [4:a]adelay=60s|60s[a4];
                        [a3][a4]amix[a];
                        [v][5:v]overlay[out]' \
       -map [out] \
       -map [a] \
       -pix_fmt yuv420p \
       -c:v libx264 \
       -c:a aac \
       -t 300 dc.mp4


# 添加图片水印

ffmpeg -i 4.mp4 \
       -i sy.png \
       -filter_complex "overlay=10:10" birds2.mp4


# 添加文字水印

ffmpeg -i 4.mp4 \
   -vf "drawtext=fontfile=/Library/Fonts/AdobeHeitiStd-Regular.otf:text='watermark测试':x=30:y=h-30:enable='if(gte(t,3),0,1)':fontsize=24:fontcolor=white@0.7" output.mp4



# 推流

ffmpeg -i f.jpg \
       -i 1.mp4 \
       -i long.mp4 \
       -i audio.mp3 \
       -i t.wav \
       -i sy.png \
       -filter_complex '[0]scale=720:1280,setpts=PTS+6/TB[in0];
                        [1:v]scale=720:1280[in1];
                        [2:v]scale=720:1280[in2];
                        [in0][in1][in2] concat=n=3:v=1:a=0 [v];
                        [3:a]adelay=30s|30s[a3];
                        [4:a]adelay=60s|60s[a4];
                        [a3][a4]amix[a];
                        [v][5:v]overlay[out]' \
       -map [out] \
       -map [a] \
       -pix_fmt yuv420p \
       -c:v libx264 \
       -c:a aac \
       -t 300 \
       -f flv "rtmp://pili-publish.xinkuanvip.com/lab-live/0_6_20191223_-bNo42kNDv?e=1577266078&token=C9wQEzo1YL8nIlTASxvVTqvEZgHjCwasoTLL1mIZ:AZY0PE4iGfrXuTnqhjyGJ55V_H0="




ffmpeg -i long.mp4 \
       -c copy \
       -f flv "rtmp://pili-publish.xinkuanvip.com/lab-live/0_6_20191223_-bNo42kNDv?e=1577168755&token=C9wQEzo1YL8nIlTASxvVTqvEZgHjCwasoTLL1mIZ:PllbVD8tqKyqVBgurVZf00MbP08="


## 合成

ffmpeg -ignore_loop 0 \
       -i 43313-1F912154415302.gif \
       -i song.aac \
       -pix_fmt yuv420p \
       -c:v libx264 \
       -c:a aac \
       -t 61 vocal.mp4