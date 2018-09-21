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

#include "QMLHighlighter.h"

class QMLBlockData: public QTextBlockUserData
{
public:
    QList<int> bracketPositions;
};


QMLHighlighter::QMLHighlighter(QTextDocument *parent) : QSyntaxHighlighter(parent)
    , m_markCaseSensitivity(Qt::CaseInsensitive)
{
    m_colors[Normal]     = QColor("#000000");
    m_colors[Comment]    = QColor("#008000");
    m_colors[Number]     = QColor("#000080");
    m_colors[String]     = QColor("#008000");
    m_colors[Operator]   = QColor("#000000");
    m_colors[Keyword]    = QColor("#808000");
    m_colors[BuiltIn]    = QColor("#0055af");
    m_colors[Marker]     = QColor("#ffff00");
    m_colors[Item]       = QColor("#800080");
    m_colors[Property]   = QColor("#800000");

    loadDictionary(":/dictionaries/keywords.txt", m_keywords);
    loadDictionary(":/dictionaries/javascript.txt", m_jsIds);
    loadDictionary(":/dictionaries/qml.txt", m_qmlIds);
    loadDictionary(":/dictionaries/properties.txt", m_properties);
}

void QMLHighlighter::setColor(ColorComponent component, const QColor &color)
{
    m_colors[component] = color;
    rehighlight();
}

void QMLHighlighter::highlightBlock(const QString &text)
{
    enum {
        Start = 0,
        Number = 1,
        Identifier = 2,
        String = 3,
        Comment = 4
    };

    QList<int> bracketPositions;

    int blockState = previousBlockState();
    int bracketLevel = blockState >> 4;
    int state = blockState & 15;
    if (blockState < 0) {
        bracketLevel = 0;
        state = Start;
    }

    int start = 0;
    int i = 0;
    while (i <= text.length()) {
        QChar ch = (i < text.length()) ? text.at(i) : QChar();
        QChar next = (i < text.length() - 1) ? text.at(i + 1) : QChar();

        switch (state) {

        case Start:
            start = i;
            if (ch.isSpace()) {
                ++i;
            } else if (ch.isDigit()) {
                ++i;
                state = Number;
            } else if (ch.isLetter() || ch == '_') {
                ++i;
                state = Identifier;
            } else if (ch == '\'' || ch == '\"') {
                ++i;
                state = String;
            } else if (ch == '/' && next == '*') {
                ++i;
                ++i;
                state = Comment;
            } else if (ch == '/' && next == '/') {
                i = text.length();
                setFormat(start, text.length(), m_colors[ColorComponent::Comment]);
            } else {
                if (!QString("(){}[]").contains(ch))
                    setFormat(start, 1, m_colors[Operator]);
                if (ch =='{' || ch == '}') {
                    bracketPositions += i;
                    if (ch == '{')
                        bracketLevel++;
                    else
                        bracketLevel--;
                }
                ++i;
                state = Start;
            }
            break;

        case Number:
            if (ch.isSpace() || !ch.isDigit()) {
                setFormat(start, i - start, m_colors[ColorComponent::Number]);
                state = Start;
            } else {
                ++i;
            }
            break;

        case Identifier:
            if (ch.isSpace() || !(ch.isDigit() || ch.isLetter() || ch == '_')) {
                QString token = text.mid(start, i - start).trimmed();
                if (m_keywords.contains(token))
                    setFormat(start, i - start, m_colors[Keyword]);
                else if (m_qmlIds.contains(token))
                    setFormat(start, i - start, m_colors[Item]);
                else if (m_properties.contains(token))
                    setFormat(start, i - start, m_colors[Property]);
                else if (m_jsIds.contains(token))
                    setFormat(start, i - start, m_colors[BuiltIn]);
                state = Start;
            } else {
                ++i;
            }
            break;

        case String:
            if (ch == text.at(start)) {
                QChar prev = (i > 0) ? text.at(i - 1) : QChar();
                if (prev != '\\') {
                    ++i;
                    setFormat(start, i - start, m_colors[ColorComponent::String]);
                    state = Start;
                } else {
                    ++i;
                }
            } else {
                ++i;
            }
            break;

        case Comment:
            if (ch == '*' && next == '/') {
                ++i;
                ++i;
                setFormat(start, i - start, m_colors[ColorComponent::Comment]);
                state = Start;
            } else {
                ++i;
            }
            break;

        default:
            state = Start;
            break;
        }
    }

    if (state == Comment)
        setFormat(start, text.length(), m_colors[ColorComponent::Comment]);
    else
        state = Start;

    if (!m_markString.isEmpty()) {
        int pos = 0;
        int len = m_markString.length();
        QTextCharFormat markerFormat;
        markerFormat.setBackground(m_colors[ColorComponent::Marker]);
        markerFormat.setForeground(m_colors[ColorComponent::Normal]);
        for (;;) {
            pos = text.indexOf(m_markString, pos, m_markCaseSensitivity);
            if (pos < 0)
                break;
            setFormat(pos, len, markerFormat);
            ++pos;
        }
    }

    if (!bracketPositions.isEmpty()) {
        QMLBlockData *blockData = reinterpret_cast<QMLBlockData*>(currentBlock().userData());
        if (!blockData) {
            blockData = new QMLBlockData;
            currentBlock().setUserData(blockData);
        }
        blockData->bracketPositions = bracketPositions;
    }

    blockState = (state & 15) | (bracketLevel << 4);
    setCurrentBlockState(blockState);
}

void QMLHighlighter::mark(const QString &str, Qt::CaseSensitivity caseSensitivity)
{
    m_markString = str;
    m_markCaseSensitivity = caseSensitivity;
    rehighlight();
}

void QMLHighlighter::loadDictionary(QString filepath, QSet<QString> &dictionary) {
    QFile file(filepath);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream textStream(&file);
    while (!textStream.atEnd()) {
        dictionary<<textStream.readLine().trimmed();
    }
}

void QMLHighlighter::addQmlComponent(QString componentName)
{
    m_qmlIds<<componentName;
}

void QMLHighlighter::addJsComponent(QString componentName)
{
    m_jsIds<<componentName;
}
