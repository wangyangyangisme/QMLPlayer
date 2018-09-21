#include "sqleventmodel.h"
#include <QDebug>
#include <QFileInfo>
#include <QSqlError>
#include <QSqlQuery>

SqlEventModel::SqlEventModel() :
    QSqlQueryModel()
{
    createConnection();     // 创建数据库
}

/* 创建数据库 */
void SqlEventModel::createConnection()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(":memory:"); //使用内存数据库
    if (!db.open()) {
        qFatal("Cannot open database");
        return;
    }

    QSqlQuery query;
    // We store the time as seconds because it's easier to query.
    query.exec("create table Event (name TEXT, startDate DATE, startTime INT, endDate DATE, endTime INT, imageNum INT)");

    query.exec("insert into Event values('pet', '2015-05-02', 57600, '2015-05-02', 61200, 9)");

    query.exec("insert into Event values('meeting', '2015-05-15', 57600, '2015-05-15', 63000, 7)");
    query.exec("insert into Event values('shopping', '2015-05-15', 39600, '2015-05-15', 576000, 11)");
    query.exec("insert into Event values('sing', '2015-05-15', 57600, '2015-05-15', 63000, 12)");
    query.exec("insert into Event values('smoking', '2015-05-15', 39600, '2015-05-15', 576000, 13)");
    query.exec("insert into Event values('airplane', '2015-05-15', 57600, '2015-05-15', 63000, 14)");

    query.exec("insert into Event values('flower', '2015-05-27', 32400, '2015-05-30', 61200, 3)");
    query.exec("insert into Event values('airplane', '2015-05-29', 57600, '2015-05-30', 63000, 14)");
    query.exec("insert into Event values('video', '2015-05-29', 57600, '2015-05-30', 63000, 15)");
    query.exec("insert into Event values('hotel', '2015-05-30', 57600, '2015-05-30', 63000, 6)");
    query.exec("insert into Event values('hairdressing', '2015-06-01', 36000, '2015-06-01', 39600, 5)");

//    QSqlQuery queryAll("SELECT * FROM Event");
//    while (queryAll.next()) {
//        qDebug() << queryAll.value("name")        << ":"
//                 << queryAll.value("startDate")   << ":"
//                 << queryAll.value("startTime")   << ":"
//                 << queryAll.value("endDate")     << ":"
//                 << queryAll.value("endTime")     << ":"
//                 << queryAll.value("imageNum");
//    }
    return;
}

/* 查找有事件的日期 */
QList<QObject*> SqlEventModel::eventsForDate(const QDate &date)
{
    const QString queryStr = QString::fromLatin1("SELECT * FROM Event WHERE '%1' >= startDate AND '%1' <= endDate").arg(date.toString("yyyy-MM-dd"));
    QSqlQuery query(queryStr);
    if (!query.exec())
        qFatal("Query failed");

    QList<QObject*> events;
    while (query.next()) {
        Event *event = new Event(this);
        event->setName(query.value("name").toString());

        QDateTime startDate;
        startDate.setDate(query.value("startDate").toDate());
        startDate.setTime(QTime(0, 0).addSecs(query.value("startTime").toInt()));
        event->setStartDate(startDate);

        QDateTime endDate;
        endDate.setDate(query.value("endDate").toDate());
        endDate.setTime(QTime(0, 0).addSecs(query.value("endTime").toInt()));
        event->setEndDate(endDate);

        event->setNum(query.value("imageNum").toString());

        events.append(event);
    }

    return events;
}

/* 从数据库中获取图片的编号 */
QString SqlEventModel::getImageNum(const QDate &date)
{
    const QString queryStr = QString::fromLatin1("SELECT * FROM Event WHERE '%1' >= startDate AND '%1' <= endDate").arg(date.toString("yyyy-MM-dd"));
    QSqlQuery query(queryStr);
    if (!query.exec())
        qFatal("Query failed");

    QString imageNum;
    while (query.next()) {
        imageNum = query.value("imageNum").toString();
        //qDebug() << "imageNum:" << imageNum;
    }
    return imageNum;
}

/* 插入一条事件 */
void SqlEventModel::insertEvent(const QDate &date)
{
    QSqlQuery query;
    query.prepare("INSERT INTO Event (name, startDate, startTime, endDate, endTime, imageNum)"
                    "VALUES (:name, :startDate, :startTime, :endDate, :endTime, :imageNum)");
    query.bindValue(":name", "luopeng");
    query.bindValue(":startDate", date);
    query.bindValue(":startTime", 36000);
    query.bindValue(":endDate", date);
    query.bindValue(":endTime", 39600);
    query.bindValue(":imageNum", 9);
    query.exec();
}

/* 删除一条事件 */
