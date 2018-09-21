#ifndef _SERIAL_H
#define _SERIAL_H
#include <termios.h>            /* tcgetattr, tcsetattr */
#include <sys/select.h>

/*
 *
 * android 系统中的头文件，用于访问硬件层的串口
 * */


typedef int INT32;
typedef short INT16;
typedef char INT8;
typedef unsigned int UNIT32;
typedef unsigned short UINT16;
typedef unsigned char UINT8;

typedef struct serial_struct {
    INT32 fd;                //File descriptor for the port
    struct termios termios_old;
    struct termios termios_new;
    fd_set fs_read;
    fd_set fs_write;
    struct timeval tv_timeout;
}serial_st;




int serial_init(serial_st *st, int port, int baudrate);
int serial_deinit(serial_st *st);

int serial_read (serial_st *st, void *data, INT32 datalength);
int serial_write (serial_st *st, UINT8 * data, INT32 datalength);

/* serial.c */

/**
 * export serial fd to other program to perform
 * directly read, write to serial.
 *
 * @return serial's file description
 */



#endif /* serial.c */

