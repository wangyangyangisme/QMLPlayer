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

#include "SyntaxHighlighter.h"

SyntaxHighlighter::SyntaxHighlighter(QObject *parent) :
    QObject(parent),
    m_highlighter(nullptr)
{
    Q_UNUSED(parent)
}

void SyntaxHighlighter::setHighlighter(QObject *textArea)
{
    QQuickTextDocument *quickTextDocument = qvariant_cast<QQuickTextDocument*>(textArea->property("textDocument"));
    QTextDocument *document = quickTextDocument->textDocument();
    m_highlighter = new QMLHighlighter(document);
    m_highlighter->rehighlight();
}

void SyntaxHighlighter::rehighlight() {
    if (m_highlighter)
        m_highlighter->rehighlight();
}

void SyntaxHighlighter::addQmlComponent(QString componentName)
{
    if (m_highlighter)
        m_highlighter->addQmlComponent(componentName);
}

void SyntaxHighlighter::addJsComponent(QString componentName)
{
    if (m_highlighter)
        m_highlighter->addJsComponent(componentName);
}
