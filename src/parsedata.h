#ifndef PARSEDATA_H
#define PARSEDATA_H


#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>
#include <ctype.h>

#ifdef __cplusplus
}
#endif
#include <uartthread.h>
#pragma pack(1)

typedef struct
{
    unsigned char soi;
    unsigned char pid;
    unsigned char res;
    unsigned char len;
    unsigned char mac[16];
    unsigned char dat[100];
    unsigned char *crc;
    unsigned char *eoi;
}Uart_Packet_Struct;

class ParseData
{
public:
    ParseData();
    ~ParseData();
    static int hex2Byte(const char* source, unsigned char* dest, int sourceLen);
    static int removeInvalidCh(const char* source,unsigned char *dest, int len);
    static int parseData(UartThread *pUartThread,unsigned char *dest, unsigned char len);

    static QString * Byte2QString(unsigned char *tmp, unsigned char len);

    static int QString2Bytes(QString * s,unsigned char *tmp);
    static unsigned char ck_sum(unsigned char * dat , unsigned char len, unsigned char flag);
};

#endif // PARSEDATA_H
