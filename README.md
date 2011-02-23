## WINDOWS 2003 系统盘制作

### 需求实现方式
#### nLite制作光盘内嵌设置
#### 首次登陆时BAT脚本

### 功能需求方
#### 机房前期需求
1. 设置IPsec（BAT实现）
2. 安装PCanywhere（BAT实现）
3. 安装Windows Hotfix（BAT实现）
4. 安装Octopod Agent（BAT实现）

#### 运维前期需求

1. 磁盘管理
    1. 创建分区->磁盘0剩余全部空间创建逻辑磁盘并格式化（BAT实现） 
    2. 设置盘符->新建逻辑磁盘设置为D盘，光驱设为H盘（BAT实现）

2. 目录管理

    1. 创建目录结构（BAT实现）

    D:\tools
        D:\winapplogs
    D:\websiteslogs
    D:\components\log
    D:\websites\*.sdo.com
    D:\webapplog
    D:\iislog
    D:\httperr

3. 界面优化

    1. 菜单->经典样式（nLite实现）
    2. 主题->经典样式（nLite实现）
    3. 桌面->800x600（nLite实现）

4. 性能稳定优化

    1. 自动更新->关闭（nLite实现）
    2. 视觉效果->调整为最佳性能（nLite实现）
    3. 虚拟内存->D: 2048 - 4096（BAT实现）
    4. 数据执行保护->只为关键Windows程序和服务启用数据执行保护（nLite实现）
    5. 远程桌面->内网开启/外网关闭

5. 网络设置

    1. 网卡名称->将IP地址设为网卡对应名称
    2. 网卡使用情况->禁用未使用的网卡
    3. Microsoft网络客户端->内网开启/外网关闭

6. 协议设置

    1. DNS服务器->指定2组DNS IP（BAT实现）
    2. NetBIOS->内网开启/外网关闭

7. 安装软件

    1. WinRAR（BAT实现）
    2. C:\Cygwin（BAT实现）
    3. D:\TotalCmd（BAT实现）

    快捷方式->cygwin、TotalCMD、服务快捷方式到桌面（BAT实现）

8. 系统服务安装设置

    1. 安装组件->SNMP、IIS（BAT实现）
    2. 安装Framework3.5SP1（BAT实现）

    3. 禁用服务（BAT实现）

    Wuauserv 服务名称：Automatic Updates自动更新服务
    Dhcp 服务名称：DHCP Client 自动分配IP地址的服务
    Browser 服务名称：Computer Browser (计算机浏览器) 看网上邻居的服务
    Messenger 服务名称：Messenger 信使服务
    Spooler 服务名称：Print Spooler 打印服务
    RemoteRegistry 服务名称：Remote Registry 远程修改注册表
    LmHosts 服务名称：TCP/IP NetBIOS Helper 提供对netbios的支持
    WZCSVC 服务名称：Wireless Zero Configuration 无线配置服务
    W3SVC 服务名称：World Wide Web Publishing Service 万维网服务IIS

    4. 停止服务（BAT实现）

    W3SVC 服务名称：World Wide Web Publishing Service 万维网服务IIS

    5. NTP Client->指定IP

### 具体操作方式可见文档
#### nLite信息可见nLite、LAST SESSION.ini、LAST SESSION_U.ini
#### BAT信息可见OM.bat