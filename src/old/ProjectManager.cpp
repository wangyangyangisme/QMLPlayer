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

#include "ProjectManager.h"

ProjectManager::ProjectManager(QObject *parent) :
    QObject(parent),
    m_exampleMode(false)
{
    QDir().mkpath(projectsDir());
}

QString ProjectManager::projectsDir()
{
    if (m_exampleMode)
        return ":/qml/Examples";
    else
        return QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + QDir::separator() + "QML Projects";
}

QString ProjectManager::currentProjectDir()
{
    if (m_exampleMode)
        return projectsDir() + QDir::separator() + m_exampleGroup + QDir::separator() + m_projectName;
    else
        return projectsDir() + QDir::separator() + m_projectName;
}

QString ProjectManager::templatesDir()
{
    return ":/qml/Templates";
}

QString ProjectManager::newFileContent(QString fileType)
{
    QString fileName = "QmlFile.qml";
    if (fileType == "main") {
        fileName = "MainFile.qml";
    } else if (fileType == "js") {
        fileName = "JsFile.js";
    }

    QFile file(templatesDir() + QDir::separator() + fileName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream textStream(&file);
    QString fileContent = textStream.readAll().trimmed();

    return fileContent;
}

QStringList ProjectManager::getProjects()
{
    QDir dir(projectsDir());
    QStringList projects;
    QFileInfoList folders = dir.entryInfoList(QDir::AllDirs | QDir::NoDotAndDotDot);

    foreach(QFileInfo folder, folders) {
        QString folderName = folder.fileName();
        projects.push_back(folderName);
    }

    return projects;
}

QString ProjectManager::currentProject()
{
    return m_projectName;
}

bool ProjectManager::createProject(QString projectName)
{
    QFileInfo checkFile(projectsDir() + QDir::separator() + projectName);
    if (checkFile.exists()) {
        m_errorText = "Project " + projectName + " already exists.";
        return false;
    } else {
        QDir dir(projectsDir());
        dir.mkdir(projectName);
        QFile file(projectsDir() + QDir::separator() + projectName + QDir::separator() + "main.qml");
        file.open(QIODevice::WriteOnly | QIODevice::Text);
        QString fileContent = "// Project \"" + projectName + "\"\n" + newFileContent("main");
        QTextStream textStream(&file);
        textStream<<fileContent;
        return true;
    }
}

bool ProjectManager::openProject(QString projectName)
{
    m_projectName = projectName;
    return true;
}

bool ProjectManager::renameProject(QString projectName, QString newProjectName)
{
    QFile::rename(projectsDir() + QDir::separator() + projectName,
                  projectsDir() + QDir::separator() + newProjectName);
    return true;
}

bool ProjectManager::removeProject(QString projectName)
{
    QDir dir(projectsDir() + QDir::separator() + projectName);
    dir.removeRecursively();
    return true;
}

void ProjectManager::closeProject()
{
    m_projectName.clear();
}

QStringList ProjectManager::getExampleGroups()
{
    QDir dir(projectsDir());
    QStringList groups;
    QFileInfoList folders = dir.entryInfoList(QDir::AllDirs | QDir::NoDotAndDotDot);

    foreach(QFileInfo folder, folders) {
        QString folderName = folder.fileName();
        groups.push_back(folderName);
    }

    return groups;
}

QStringList ProjectManager::getExamplesFromGroup(QString groupName)
{
    QDir dir(projectsDir() + QDir::separator() + groupName);
    QStringList examples;
    QFileInfoList folders = dir.entryInfoList(QDir::AllDirs | QDir::NoDotAndDotDot);

    foreach(QFileInfo folder, folders) {
        QString folderName = folder.fileName();
        examples.push_back(folderName);
    }

    return examples;
}

QStringList ProjectManager::getFiles()
{
    QDir dir(currentProjectDir());
    QStringList projectFiles;
    QFileInfoList files = dir.entryInfoList(QDir::Files);

    foreach(QFileInfo file, files) {
        QString fileName = file.fileName();
        projectFiles.push_back(fileName);
    }

    return projectFiles;
}

QString ProjectManager::currentFile()
{
    return m_fileName;
}

QString ProjectManager::projectMainPath()
{
    QString pathPrefix = (m_exampleMode) ? "qrc" : "file:///";
    return pathPrefix + currentProjectDir() + QDir::separator() + "main.qml";
}

bool ProjectManager::createFile(QString fileName, QString fileExtension)
{
    QFileInfo checkFile(currentProjectDir() + QDir::separator() + fileName + "." + fileExtension);
    if (checkFile.exists()) {
        m_errorText = "File " + fileName + "." + fileExtension + " already exists.";
        return false;
    } else {
        QFile file(currentProjectDir() + QDir::separator() + fileName + "." + fileExtension);
        file.open(QIODevice::WriteOnly | QIODevice::Text);
        QTextStream textStream(&file);
        textStream<<newFileContent(fileExtension);
        return true;
    }
}

bool ProjectManager::openFile(QString fileName)
{
    m_fileName = fileName;
    return true;
}

bool ProjectManager::renameFile(QString fileName, QString newFileName)
{
    QFile::rename(currentProjectDir() + QDir::separator() + fileName,
                  currentProjectDir() + QDir::separator() + newFileName);
    return true;
}

bool ProjectManager::removeFile(QString fileName)
{
    QDir().remove(currentProjectDir() + QDir::separator() + fileName);
    return true;
}

void ProjectManager::closeFile()
{
    m_fileName.clear();
}

QString ProjectManager::getFileContent()
{
    QFile file(currentProjectDir() + QDir::separator() + m_fileName);
    file.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream textStream(&file);
    QString fileContent = textStream.readAll().trimmed();
    return fileContent;
}

void ProjectManager::saveFileContent(QString content)
{
    QFile file(currentProjectDir() + QDir::separator() + m_fileName);
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream textStream(&file);
    textStream<<content;
}

QQmlApplicationEngine *ProjectManager::m_qmlEngine;

void ProjectManager::clearComponentCache()
{
    ProjectManager::m_qmlEngine->clearComponentCache();
}

void ProjectManager::setQmlEngine(QQmlApplicationEngine *engine)
{
    ProjectManager::m_qmlEngine = engine;
}

QString ProjectManager::errorText()
{
    return m_errorText;
}
