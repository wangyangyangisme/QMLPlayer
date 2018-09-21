#ifndef EVENT_H
#define EVENT_H

#include <QDateTime>
#include <QObject>
#include <QString>

class Event : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString   name       READ name       WRITE setName       NOTIFY nameChanged)
    Q_PROPERTY(QDateTime startDate  READ startDate  WRITE setStartDate  NOTIFY startDateChanged)
    Q_PROPERTY(QDateTime endDate    READ endDate    WRITE setEndDate    NOTIFY endDateChanged)
    Q_PROPERTY(QString   num        READ num        WRITE setNum        NOTIFY numChanged)

public:
    explicit Event(QObject *parent = 0);

    QString name() const;
    QDateTime startDate() const;
    QDateTime endDate() const;
    QString num() const;

    void setName(const QString &name);
    void setStartDate(const QDateTime &startDate);
    void setEndDate(const QDateTime &endDate);
    void setNum(const QString &num);

signals:
    void nameChanged(const QString &name);
    void startDateChanged(const QDateTime &startDate);
    void endDateChanged(const QDateTime &endDate);
    void numChanged(const QString &num);

private:
    QString mName;
    QDateTime mStartDate;
    QDateTime mEndDate;
    QString mNum;
};

#endif
