#ifndef SQLEVENTMODEL_H
#define SQLEVENTMODEL_H

#include <QList>
#include <QObject>
#include <QDate>
#include <QSqlTableModel>

#include "event.h"

class SqlEventModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    SqlEventModel();

    Q_INVOKABLE QList<QObject*> eventsForDate(const QDate &date);
    Q_INVOKABLE QString getImageNum(const QDate &date);
    Q_INVOKABLE void insertEvent(const QDate &date);

private:
    static void createConnection();
};

#endif
