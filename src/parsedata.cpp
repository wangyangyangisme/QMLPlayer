#include "parsedata.h"
#include "devices.h"

ParseData::ParseData()
{
}

ParseData::~ParseData()
{
}

int ParseData::hex2Byte(const char* source, unsigned char* dest, int sourceLen)
{
    int i, l=0;
    unsigned char highByte, lowByte;

    for (i = 0; i < sourceLen; i += 2)
    {
        highByte = toupper(source[i]);
        lowByte  = toupper(source[i + 1]);

        if (highByte > 0x39)
            highByte -= 0x37;
        else
            highByte -= 0x30;

        if (lowByte > 0x39)
            lowByte -= 0x37;
        else
            lowByte -= 0x30;

        dest[i / 2] = (highByte << 4) | lowByte;
        l++;
    }
    return l;

}

int ParseData::removeInvalidCh(const char* source, unsigned char *dest, int len)
{
    int i, tlen = 0;

    for(i = 0; i < len; i++){
        if(!isxdigit(source[i]))
            continue;
        dest[tlen] = source[i];
        tlen++;
    }
    return tlen;
}

QString * ParseData::Byte2QString(unsigned char *tmp, unsigned char len)
{
    QString *qs;
    unsigned char stmp[1024];
    int i;

    for(i = 0; i < len; i++){
        sprintf((char *)(stmp + i * 2),"%02x", tmp[i]);
    }
    qs = new QString((const char *)stmp);

    return qs;
}

int ParseData::QString2Bytes(QString * s,unsigned char *tmp)
{
    int len;
    unsigned char wbuf[1024];

    sprintf((char *)(tmp), "%s", s->toLocal8Bit().data());

    len = strlen((const char *)tmp);
    len = ParseData::removeInvalidCh((const char *)tmp, wbuf, len);
    len = ParseData::hex2Byte((const char *)wbuf, tmp, len);

    return len;
}

/********************************************
函数名：ck_sum  created by liucky
输入参数：dat ,flag
        dat ：输入要校验或者处理的数据指针
        len ：数据长度
        flag :
              0x00 校验数据
              0x01 生成校验
输出参数：dat ,ch_sum
        dat ：校验数据结果覆盖原文件
        ch_sum ：返回数据校验结果
              0x00  ：校验成功
              0x01  ：校验错误
              0x02  ：参数错误
              0x03  ：数据长度错误

              len+6 ：生成校验数据长度
********************************************/
unsigned char ParseData::ck_sum(unsigned char * dat , unsigned char len, unsigned char flag)
{
    unsigned char i;
    unsigned char crc_tmp = 0;
    unsigned char PID = 0;

    Uart_Packet_Struct *dat_tmp = ( Uart_Packet_Struct *)dat;

    /*******************************************************************/
    if(flag == 0)
    {
        //判断校验
        if(dat_tmp->soi != 0x7E)
        {
            return 0x02;
        }
        if(len != dat_tmp->len+6)
        {
            return 0x03;
        }
    }
    else if(flag == 1)
    {
        //生成校验
        dat_tmp->soi = 0x7e;
        dat_tmp->len = len;
        dat_tmp->res = 0;
    }
    else
    {
        return 0x02;
    }

    dat_tmp->eoi = &(dat_tmp->mac[dat_tmp->len+1]);

    dat_tmp->crc = &(dat_tmp->mac[dat_tmp->len]);

    //判断PID的合法性
    PID = ~(dat_tmp->pid);
    PID >>= 4;
    PID &= 0x0F;
    if((dat_tmp->pid&0x0F) != PID)
    {
        return 0x02;
    }

    for(i=0 ; i<dat_tmp->len+2 ; i++)
    {
        crc_tmp += dat[i+1] ;
    }
    if(flag == 0)
    {
        if((((unsigned char)*(dat_tmp->crc))==crc_tmp) && (((unsigned char)*(dat_tmp->eoi))==0x0d))
        {
            return 0x00;
        }
        return 0x01;
    }
    else
    {
        *(dat_tmp->crc) = crc_tmp;
        *(dat_tmp->eoi) = 0x0D;
        return (dat_tmp->len+6);
    }
}


int ParseData::parseData(UartThread * pUartThread,unsigned char *dest, unsigned char len)
{
    unsigned char type=0;

    type = ParseData::ck_sum(dest, len, 0);

    if(type != 0){
        qDebug("ck_sum %d",type);
        return 0;
    }

    Uart_Packet_Struct *dat_tmp = (Uart_Packet_Struct *)dest;
    pUartThread->MessageToQml(dat_tmp->pid, dat_tmp->mac, dat_tmp->len);

    return 0;
}
