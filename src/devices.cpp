#include "devices.h"

Devices::Devices()
{

}

Devices::~Devices()
{

}

int Devices::getNextDeviceID()
{
    return m_devices.count();
}

//bool Devices::addDevice(int id,unsigned char *m, int len)
//{
//    m_devices.push_back(TDevice(id,m,len));

//    return true;
//}

//bool Devices::hasDevice(unsigned char *pmac,int len)
//{
//    QList<TDevice>::iterator i;
//    unsigned char *p;
//    unsigned char maclen;

//    for (i = m_devices.begin(); i != m_devices.end(); ++i){
//        p = i->getMac(maclen);
//        if(memcmp(pmac,p,maclen)==0){
//            return true;
//        }
//    }
//    return false;
//}

//bool Devices::delDevice(int id)
//{
//    QList<TDevice>::iterator i;

//    for (i = m_devices.begin(); i != m_devices.end(); ++i){

//        if(id == i->getID()){
//            m_devices.erase(i);
//            return true;
//        }
//    }
//    return false;
//}

unsigned char *Devices::getDeviceMac(int id,unsigned char &len)
{
    unsigned char *pmac;

    QList<TDevice>::iterator i;

    for (i = m_devices.begin(); i != m_devices.end(); ++i){
        if(i->getID()==id){
            pmac = i->getMac(len);
            return pmac;
        }
    }
    return 0;
}
