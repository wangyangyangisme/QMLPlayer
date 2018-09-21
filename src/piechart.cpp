#include "piechart.h"


PieChart::PieChart(QQuickItem *parent)
    : QQuickItem(parent)
{
}

void PieChart::toCPP()
{
    //setColor(QColor(Qt::transparent));
    update();

    emit chartCleared();
    emit toQml();
}

void PieChart::setChartId(int chartId)
{
    m_id = chartId;
}

int PieChart::chartId() const
{
    return m_id;
}

PieSlice *PieChart::pieSlice() const
{
    return m_pieSlice;
}

void PieChart::setPieSlice(PieSlice *pieSlice)
{
    m_pieSlice = pieSlice;
    pieSlice->setParentItem(this);
}


QQmlListProperty<PieSlice> PieChart::slices()
{
    return QQmlListProperty<PieSlice>(this, 0, &PieChart::append_slice, 0, 0, 0);
}

void PieChart::append_slice(QQmlListProperty<PieSlice> *list, PieSlice *slice)
{
    PieChart *chart = qobject_cast<PieChart *>(list->object);
    if (chart) {
        slice->setParentItem(chart);
        chart->m_slices.append(slice);
    }
}
