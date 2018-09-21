QT += core gui widgets qml quick sensors sql multimedia websockets

QMAKE_CXXFLAGS += -std=c++11

TARGET = qmlplayer
TEMPLATE = app

CONFIG += mobility
MOBILITY =

INCLUDEPATH += $$PWD/src
HEADERS += \
    src/event.h \
    src/sqleventmodel.h \


SOURCES += \
    src/main.cpp\   
    src/event.cpp \
    src/sqleventmodel.cpp \


RESOURCES += \
    QMLPlayer.qrc

RC_FILE = QMLPlayer.rc


android {
    QT += androidextras
    OTHER_FILES += android/AndroidManifest.xml
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    src/uart.h \
    src/uartthread.h \
    src/parsedata.h \
    src/hidapi.h \
    src/qtquickcontrolsapplication.h \
    src/csingleton.h

SOURCES += \
    src/uart.cpp \
    src/uartthread.cpp \
    src/parsedata.cpp \
    src/csingleton.cpp

LIBS += $$PWD\libs/libuart.so

DISTFILES += \
    $$PWD/android/src/com/insmart/qmlplayer/WifiAdmin.java \
    $$PWD/android/src/com/insmart/qmlplayer/AccessPoint.java \
    $$PWD/android/src/com/insmart/qmlplayer/BluetoothLeService.java \
    $$PWD/android/src/com/insmart/qmlplayer/SampleGattAttributes.java

OTHER_FILES += android/AndroidManifest.xml\
                android/res/xml/device_filter.xml\
                android/src/com/insmart/qmlplayer/Settings.java
}

ios {
    ICON_DATA.files = \
        $$PWD/ios/Icon.png \
        $$PWD/ios/Icon@2x.png \
        $$PWD/ios/Icon-60.png \
        $$PWD/ios/Icon-60@2x.png \
        $$PWD/ios/Icon-72.png \
        $$PWD/ios/Icon-72@2x.png \
        $$PWD/ios/Icon-76.png \
        $$PWD/ios/Icon-76@2x.png \
        $$PWD/ios/Def.png \
        $$PWD/ios/Def@2x.png \
        $$PWD/ios/Def-Portrait.png \
        $$PWD/ios/Def-568h@2x.png
    QMAKE_BUNDLE_DATA += ICON_DATA

    QMAKE_INFO_PLIST = $$PWD/ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}
