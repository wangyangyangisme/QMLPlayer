#ifndef DEVICES_H
#define DEVICES_H
#include <QList>
class Devices
{

public:
    Devices();
    ~Devices();

//    bool addDevice(int id,unsigned char *m, int len);
//    bool hasDevice(unsigned char *pmac,int len);
//    bool delDevice(int id);
    unsigned char *getDeviceMac(int id,unsigned char &len);
    int getNextDeviceID();

private:
    class TDevice{
    public:
        TDevice(int id,unsigned char *m, int len){mid = id;memcpy(mac,m,len);mac_len=len;}
        unsigned char *getMac(unsigned char &m){m=mac_len;return mac;}
        //bool setMac(unsigned char *m, int len);
        int getID(){return mid;}
        //bool operator==(TDevice &t) {if(memcmp(mac,t.getMac(),8))return true;return false;}
    private:
        unsigned char mac[20];
        unsigned char mac_len;
        int mid;

    };

    QList<TDevice> m_devices;

};

#endif // DEVICES_H
