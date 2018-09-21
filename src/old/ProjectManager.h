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

#ifndef PROJECTMANAGER_H
#define PROJECTMANAGER_H

#include <QObject>
#include <QFile>
#include <QFileInfo>
#include <QDir>
#include <QIODevice>
#include <QStandardPaths>
#include <QTextStream>
#include <QtQml/QQmlApplicationEngine>

class ProjectManager : public QObject
{
    Q_OBJECT

    // examples
    Q_PROPERTY(bool exampleMode MEMBER m_exampleMode READ getExampleMode WRITE setExampleMode NOTIFY exampleModeChanged)
    Q_PROPERTY(QString exampleGroup MEMBER m_exampleGroup READ getExampleGroup WRITE setExampleGroup NOTIFY exampleGroupChanged)

public:
    explicit ProjectManager(QObject *parent = 0);

    // project management
    Q_INVOKABLE QStringList getProjects();
    Q_INVOKABLE QString currentProject();
    Q_INVOKABLE bool createProject(QString projectName);
    Q_INVOKABLE bool openProject(QString projectName);
    Q_INVOKABLE bool renameProject(QString projectName, QString newProjectName);
    Q_INVOKABLE bool removeProject(QString projectName);
    Q_INVOKABLE void closeProject();

    // examples
    Q_INVOKABLE QStringList getExampleGroups();
    Q_INVOKABLE QStringList getExamplesFromGroup(QString groupName);

    // current project
    Q_INVOKABLE QStringList getFiles();
    Q_INVOKABLE QString currentFile();
    Q_INVOKABLE QString projectMainPath();
    Q_INVOKABLE bool createFile(QString fileName, QString fileExtension);
    Q_INVOKABLE bool openFile(QString fileName);
    Q_INVOKABLE bool renameFile(QString fileName, QString newFileName);
    Q_INVOKABLE bool removeFile(QString fileName);
    Q_INVOKABLE void closeFile();

    // current file
    Q_INVOKABLE QString getFileContent();
    Q_INVOKABLE void saveFileContent(QString content);

    // QML engine stuff
    Q_INVOKABLE void clearComponentCache();
    static void setQmlEngine(QQmlApplicationEngine *engine);

    // error management
    Q_INVOKABLE QString errorText();

protected:
    // project management
    QString projectsDir();
    QString currentProjectDir();
    QString templatesDir();
    QString newFileContent(QString fileType);

    // current project
    QString m_projectName;

    // current file
    QString m_fileName;

    // QML engine stuff
    static QQmlApplicationEngine *m_qmlEngine;

    // error management
    QString m_errorText;

    // examples
    bool m_exampleMode;
    void setExampleMode(bool exampleMode) {
        m_exampleMode = exampleMode;
        emit exampleModeChanged();
    }
    bool getExampleMode() { return m_exampleMode; }

    QString m_exampleGroup;
    void setExampleGroup(QString exampleGroup) {
        m_exampleGroup = exampleGroup;
        emit exampleGroupChanged();
    }
    QString getExampleGroup() { return m_exampleGroup; }

signals:
    void exampleModeChanged();
    void exampleGroupChanged();
};

#endif // PROJECTMANAGER_H
