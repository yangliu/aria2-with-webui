Aria2 without web-ui
---
smaller than 29Mb.  
Edit config file out of the image.  
Move file completed to another folder.  
(Tasks that contains more than one files will not be moved.)  

### Install
I. replace **/DOWNLOAD_DIR** and **/CONFIG_DIR** for save data, and **YOUR_SECRET_CODE** for security. Run command below  
```
sudo docker run -d \
--name aria2 \
-p 6800:6800 \
-v /DOWNLOAD_DIR:/data \
-v /CONFIG_DIR:/conf \
-e SECRET=YOUR_SECRET_CODE \
yangliu/aria2
```

### Build:  
`sudo docker build -f Dockerfile -t yangliu/aria2 .`  

### Link:  
https://github.com/aria2/aria2  
https://github.com/acgotaku/BaiduExporter  
