/****************************************************************************
**
** Copyright (C) 2013-2015 Oleg Yadrov.
** Contact: wearyinside@gmail.com
**
** This file is part of QML Creator.
**
** QML Creator is free software: you can redistribute it and/or modify
** it under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** QML Creator is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
** GNU General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with QML Creator. If not, see http://www.gnu.org/licenses/.
**
****************************************************************************/

#ifndef SYNTAXHIGHLIGHTER_H
#define SYNTAXHIGHLIGHTER_H

#include <QObject>
#include <QQuickTextDocument>
#include "QMLHighlighter.h"

class SyntaxHighlighter : public QObject
{
    Q_OBJECT

public:
    explicit SyntaxHighlighter(QObject *parent = 0);
    Q_INVOKABLE void setHighlighter(QObject *textArea);
    Q_INVOKABLE void rehighlight();
    Q_INVOKABLE void addQmlComponent(QString componentName);
    Q_INVOKABLE void addJsComponent(QString componentName);

private:
    QMLHighlighter *m_highlighter;
};


#endif // SYNTAXHIGHLIGHTER_H
