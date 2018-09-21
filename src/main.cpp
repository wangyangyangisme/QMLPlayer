#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QtQuick/QQuickView>
#include <QIcon>
#include "sqleventmodel.h"
#include "qtquickcontrolsapplication.h"

#ifdef andriod
#include <uartthread.h>
#endif

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setWindowIcon(QIcon("QMLPlayer.ico"));

    app.setApplicationName("QML Player");
    app.setApplicationVersion("1.0.0");
    app.setOrganizationName("insmart");
    app.setOrganizationDomain("com.insmart.qmlplayer");

#ifdef andriod
    // 首先注册一下类
    qmlRegisterType<UartThread>(
                "UartT",		    // 统一资源标识符
                1,                  // 主版本
                0,					// 次版本
                "UartThread" );		// QML类名称
#endif

    qmlRegisterType<SqlEventModel>("org.qtproject.examples.calendar", 1, 0, "SqlEventModel");

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/qml/QMLPlayer.qml"));

    return app.exec();
}
