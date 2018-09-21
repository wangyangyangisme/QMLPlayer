#include "uart.h"

int Uart::write(unsigned char *buf,int len)
{
    int length;

    length = serial_write(&local_communication,buf,len);
    return length;
}

int Uart::read(unsigned char *buf,int len)
{
    int length;

    length = serial_read(&local_communication,buf,len);
    return length;

}
