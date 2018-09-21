#ifndef PIECHART_H
#define PIECHART_H


#include <QtQuick/QQuickItem>
#include <QColor>

#include <pieslice.h>

class PieChart :public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(PieSlice* pieSlice READ pieSlice WRITE setPieSlice)
    Q_PROPERTY(int chartId READ chartId WRITE setChartId NOTIFY chartIdChanged)
    Q_PROPERTY(QQmlListProperty<PieSlice> slices READ slices)

public:
    PieChart(QQuickItem *parent = 0);
    Q_INVOKABLE void toCPP();

    QQmlListProperty<PieSlice> slices();

    PieSlice *pieSlice() const;
    void setPieSlice(PieSlice *pieSlice);

    void setChartId(int chartId);
    int chartId() const;

signals:
    void chartCleared();
    void toQml();

    void chartIdChanged();

private:

    static void append_slice(QQmlListProperty<PieSlice> *list, PieSlice *slice);

    QString m_name;
    QList<PieSlice *> m_slices;

    PieSlice * m_pieSlice;
    int m_id;
};

#endif
