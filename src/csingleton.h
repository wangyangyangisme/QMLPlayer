#ifndef CSINGLETON_H
#define CSINGLETON_H
#include "uartthread.h"
class UartThread;
class CSingleton
{
private:
    CSingleton(UartThread* u)   //构造函数是私有的
    {
        pu = u;
    }
    static CSingleton *m_pInstance;
    UartThread *pu;

public:
    static CSingleton * GetInstance(UartThread* pu)
    {
        if(m_pInstance == NULL)  //判断是否第一次调用
            m_pInstance = new CSingleton(pu);
        return m_pInstance;
    }

    UartThread * getCurUartThread()
    {
        return pu;
    }
};

#endif // CSINGLETON_H
