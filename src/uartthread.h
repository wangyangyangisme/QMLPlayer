#ifndef UARTTHREAD_H
#define UARTTHREAD_H

#include <QtQuick/QQuickItem>
#include <QThread>
#include <uart.h>
#include "csingleton.h"
class CSingleton;
class UartThread : public QThread
{
    Q_OBJECT
public:
    enum State{
        IDLE_STATE = 0,
        SETTINGS_STATE,
    };
    void scanDev(const QString &dev_name,const QString &dev_addr);
    void scanEnd(void);
    void connectSuccess(void);
    void connectError(void);

public:

    UartThread(QObject *parent = NULL) : QThread(parent)
    {
        stopped = false;
        pUart = new Uart();
        allInit();
    }
    ~UartThread();
    void stop();
    Q_INVOKABLE void writeUart(const QString &buf);
    Q_INVOKABLE void settings();

    Q_INVOKABLE QString Get_Device_Name(int p);
    Q_INVOKABLE QString Get_Device_Addr(int p);
    Q_INVOKABLE int Get_Device_cnt(void);
    Q_INVOKABLE QString getString(const QString &qs, int from, int n);
    Q_INVOKABLE void sendString(int type, const QString &mac,const QString &dat);
    Q_INVOKABLE int getByte(const QString &qs, int n);
    Q_INVOKABLE void qmlDebug(int t);
    Q_INVOKABLE void scanning4Device(void);
    Q_INVOKABLE void stopScanning(void);
    Q_INVOKABLE void disconnect(void);
    Q_INVOKABLE void connect2device(const QString &qs);
    Q_INVOKABLE int sendData(const QString &qs);

    void MessageToQml(unsigned char type,unsigned char * tmp, unsigned char len);
    void startServer(void);

protected:
    void run() Q_DECL_OVERRIDE;

signals:
    void uartQml(const QString &qs);
    void scanDevRes(const QString &dev_name,const QString &dev_addr);
    void scanDevEnd(void);
    void connectedSuccess(void);
    void connectedError(void);
    void messageToQml(int type,const QString &mac,const QString &dat);

private:
    void readUart();
    void allInit();

    volatile bool stopped;
    unsigned char rbuf[1024];

    Uart *pUart;
};



#endif // UARTTHREAD_H
