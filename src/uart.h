#ifndef UART_H
#define UART_H


#ifdef __cplusplus
extern "C" {
#endif

#include <serial.h>

#ifdef __cplusplus
}
#endif


class Uart
{

public:
    Uart()
    {
        serial_init(&local_communication, 3, 115200);
    }
    int write(unsigned char *buf,int len);
    int read(unsigned char *buf,int len);
    ~Uart()
    {
        serial_deinit(&local_communication);
    }

private:
    serial_st local_communication;
};

#endif // UART_H
