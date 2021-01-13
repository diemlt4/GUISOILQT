#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtSql/QSqlDatabase>
#include <QtDebug>
#include <QSqlError>
#include <QQuickStyle>
#include <QtQuick/QQuickView>

#include "services.h"
#include "mymqtt.h"

void connectDTB()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("127.0.0.1");
    db.setDatabaseName("test");
    db.setPort(3306);
    db.setUserName("root");
    db.setPassword("");
    bool ok = db.open();
    if(ok)
        qDebug( "open ok");
    else
    {
        qDebug("open failed");
        qDebug() << db.lastError().text();
    }
    db.close();
}
int main(int argc, char *argv[])
{
    QVariantList data;
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Material");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    QQmlContext *context = engine.rootContext();
    //connectDTB();
    Services ser(context);
    context->setContextProperty("Services", &ser);
    QMqttClient *client = new QMqttClient(nullptr);
    //context->setContextProperty("Table", ser.getTransactionData(""));
    engine.load(url);



    return app.exec();
}
