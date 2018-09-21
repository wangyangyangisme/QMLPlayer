#include "uartthread.h"
#include "csingleton.h"
#include <parsedata.h>
#include <QAndroidJniObject>
#include <QtAndroid>
#include <QAndroidJniEnvironment>

void UartThread::run()
{
    startServer();
    while(!stopped)
    {
        readUart();
    }
    stopped = false;

    delete(pUart);
}

void UartThread::readUart()
{
    unsigned char tmp[1024];
    int i;
    int len;
    QString *qs;

    len = pUart->read(rbuf, 1024);
    if(len != 0){
        for(i = 0; i < len; i++){
            sprintf((char *)(tmp + i * 3)," %02x", rbuf[i]);
        }
        ParseData::parseData(this,rbuf, (unsigned char)len);

        qs = new QString((const char *)tmp);
        emit uartQml(*qs);
        len = 0;

    }
}

void UartThread::MessageToQml(unsigned char type,unsigned char *tmp, unsigned char len)
{
    QString *mac,*dat;
    int t;

    t = type;
    mac = ParseData::Byte2QString(tmp, 16);
    dat = ParseData::Byte2QString(tmp + 16, len - 16);
    emit messageToQml(t, *mac, *dat);
}



void UartThread::sendString(int type, const QString &mac,const QString &dat)
{
    unsigned char len,l;

    Uart_Packet_Struct send_bufs;

    QString *s = new QString(mac);

    send_bufs.pid = type;

    s->remove(QChar(' '), Qt::CaseInsensitive);
    len = ParseData::QString2Bytes(s, send_bufs.mac);

    s = new QString(dat);

    s->remove(QChar(' '), Qt::CaseInsensitive);
    len = ParseData::QString2Bytes(s, send_bufs.dat);

    l = ParseData::ck_sum((unsigned char *)&send_bufs, len + 16, 1);

    pUart->write((unsigned char *)&send_bufs, l);
}

QString UartThread::getString(const QString &qs, int from, int n)
{
    QString s;
    if (qs.length()<(from+n)*2)
        return NULL;
    s = qs.mid(from*2,n*2);

    return s;
}

void UartThread::qmlDebug(int t)
{
    qDebug("-- %02x",t);
}

int UartThread::getByte(const QString &qs, int n)
{
    QString s;
    int t;

    if (qs.length()<n*2)
        return 0;
    s = qs.mid(n*2, 2);

    ParseData::QString2Bytes(&s, (unsigned char *)&t);

    t = t&0xFF;

    return t;
}

void UartThread::settings()
{
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    activity.callMethod<void>("bluetoothSettings");
}

void UartThread::startServer(void)
{
}


void UartThread::scanning4Device(void)
{
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    activity.callMethod<void>("scanning4Device");
}

void UartThread::stopScanning(void)
{
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    activity.callMethod<void>("stopScanning");
}

void UartThread::disconnect(void)
{
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    activity.callMethod<void>("disconnect");
}

int UartThread::Get_Device_cnt(void)
{
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    int i = activity.callMethod<jint>("Get_Device_cnt", "(V)I;");

    return i;
}

int UartThread::sendData(const QString &str)
{
    QAndroidJniObject string1= QAndroidJniObject::fromString(str);
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    return activity.callMethod<jint>("sendData", "(Ljava/lang/String;)I",string1.object<jstring>());
}

QString UartThread::Get_Device_Name(int p)
{
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    QAndroidJniObject a = activity.callObjectMethod("Get_Device_Name","(I)Ljava/lang/String;",p);

    return a.toString();
}

QString UartThread::Get_Device_Addr(int p)
{
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    QAndroidJniObject a =  activity.callObjectMethod("Get_Device_Addr","(I)Ljava/lang/String;",p);
    return a.toString();
}

void UartThread::connect2device(const QString &address)
{
    QAndroidJniObject string1 = QAndroidJniObject::fromString(address);
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    activity.callMethod<void>("connect2device","(Ljava/lang/String;)V",string1.object<jstring>());
}

void UartThread::writeUart(const QString &buf)
{
    unsigned char tmp[1024];
    int len;

    len = ParseData::QString2Bytes((QString *)&buf,tmp);

    pUart->write(tmp, len);
}

UartThread::~UartThread()
{
    stop();
}


void UartThread::stop()
{
    stopped = true;
}


void UartThread::scanDev(const QString &dev_name,const QString &dev_addr)
{
    emit scanDevRes(dev_name,dev_addr);
}

void UartThread::scanEnd()
{
    emit scanDevEnd();
}

void UartThread::connectSuccess()
{
    emit connectedSuccess();
}

void UartThread::connectError()
{
    emit connectedError();
}


void UartThread::allInit()
{
    CSingleton::GetInstance(this);
}

extern "C"
{


void fromJavaOne(JNIEnv *env, jobject thiz, jint x)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)
    qDebug() << x << "< 100";
}

void fromJavaTwo(JNIEnv *env, jobject thiz, jint x)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)
    qDebug() << x << ">= 100";
}



void fromJavaDev(JNIEnv *env, jobject thiz, jstring dev_name,jstring dev_addr)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)
    QAndroidJniObject myJavaString("java/lang/String", "(Ljava/lang/String;)V", dev_name);
    QString name_qstring = myJavaString.toString();

    QAndroidJniObject myNewJavaString("java/lang/String", "(Ljava/lang/String;)V", dev_addr);
    QString addr_qstring = myNewJavaString.toString();

    CSingleton::GetInstance(NULL)->getCurUartThread()->scanDev(name_qstring, addr_qstring);
}

void fromJavaEnd(JNIEnv *env, jobject thiz)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)
    CSingleton::GetInstance(NULL)->getCurUartThread()->scanEnd();
}

void fromJavaConnectSuccess(JNIEnv *env, jobject thiz)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)
    CSingleton::GetInstance(NULL)->getCurUartThread()->connectSuccess();
}

void fromJavaConnectError(JNIEnv *env, jobject thiz)
{
    Q_UNUSED(env)
    Q_UNUSED(thiz)
    CSingleton::GetInstance(NULL)->getCurUartThread()->connectError();
}




JNIEXPORT jint JNI_OnLoad(JavaVM* vm, void* /*reserved*/)
{

#if 0
    QAndroidJniEnvironment env;
    if (vm->GetEnv(reinterpret_cast<void**>(&env), JNI_VERSION_1_6)
            != JNI_OK) {
        return JNI_ERR;
    }
    JNINativeMethod methods[] {{"callNativeOne", "(I)V", reinterpret_cast<void *>(fromJavaOne)},
        {"callNativeTwo", "(I)V", reinterpret_cast<void *>(fromJavaTwo)},
        {"callNativeDev", "(Ljava/lang/String;Ljava/lang/String;)V", reinterpret_cast<void *>(fromJavaDev)}};
    {"callNativeEnd", "(V)V", reinterpret_cast<void *>(fromJavaEnd)}};
jclass javaClass = env->FindClass("com/insmart/qmlplayer/FooJavaClass");
if (!javaClass){
    qDebug() << "registerNativeMethods";
    return JNI_ERR;
}

if (env->RegisterNatives(javaClass, methods,
                         sizeof(methods) / sizeof(methods[0])) < 0) {
    return JNI_ERR;
}

return JNI_VERSION_1_6;

#else

    Q_UNUSED(vm);

    JNINativeMethod methods[] {{"callNativeOne", "(I)V", reinterpret_cast<void *>(fromJavaOne)},
        {"callNativeTwo", "(I)V", reinterpret_cast<void *>(fromJavaTwo)},
        {"callNativeDev", "(Ljava/lang/String;Ljava/lang/String;)V", reinterpret_cast<void *>(fromJavaDev)},
        {"callNativeEnd", "()V", reinterpret_cast<void *>(fromJavaEnd)},
        {"callNativeConnectSuccess", "()V", reinterpret_cast<void *>(fromJavaConnectSuccess)},
        {"callNativeConnectError", "()V", reinterpret_cast<void *>(fromJavaConnectError)}};

    QAndroidJniObject javaClass("com/insmart/qmlplayer/FooJavaClass");
    QAndroidJniEnvironment env;
    qDebug() << "GetObjectClass";
    jclass objectClass = env->GetObjectClass(javaClass.object<jobject>());
    if (!objectClass){

        return JNI_ERR;
    }
    qDebug() << "RegisterNatives";
    env->RegisterNatives(objectClass,
                         methods,
                         sizeof(methods) / sizeof(methods[0]));
    qDebug() << "DeleteLocalRef";
    env->DeleteLocalRef(objectClass);
    return JNI_VERSION_1_6;
#endif

}

void foo()
{
    const QAndroidJniObject& activity = QtAndroid::androidActivity();
    activity.callMethod<void>("com/insmart/qmlplayer/Settings/FooJavaClass", "foo", "(I)V", 10);  // Output: 10 < 100
    activity.callMethod<void>("com/insmart/qmlplayer/Settings/FooJavaClass", "foo", "(I)V", 100); // Output: 100 >= 100
}
}
